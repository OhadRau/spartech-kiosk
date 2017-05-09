open Lwt
open Batteries
open Opium.Std

open UserData

let config = Configuration.get_config "/etc/kiosk/config.json"

let new_user = post "/new/" begin fun req ->
    App.urlencoded_pairs_of_body req >>= fun params ->
    let post_param name = List.assoc name params |> List.hd in
    let firstname = post_param "firstname"
    and lastname  = post_param "lastname"
    and email     = post_param "email"
    and username  = post_param "username"
    and password  = post_param "password"
    and code      = post_param "code" in
    if Db.new_user ~firstname ~lastname ~email ~username ~password ~code
      then redirect' (Uri.of_string "/")
      else redirect' (Uri.of_string "/signup/")
  end

let signup = get "/signup/" begin fun req ->
    if config.gen_admin_keys then Db.create_signup_code ();
    let page = Printf.sprintf [%blob "../template/signup.html"]
      config.school_name config.school_name config.school_name in
    `String page |> respond'
  end

let ticket_page = get "/ticket/:id" begin fun req ->
    let id = param req "id" |> int_of_string in
    match Db.get_ticket ~id with
    | Some (name, issue, timestamp, assigned) ->
      let page = Printf.sprintf [%blob "../template/ticket.html"]
        config.school_name id config.school_name id name issue
        (format_time timestamp) assigned id in
      `String page |> respond'
    | None -> redirect' (Uri.of_string "/tickets/")
  end

let close_ticket_page = post "/close/" begin fun req ->
    App.urlencoded_pairs_of_body req >>= fun params ->
    let post_param name = List.assoc name params |> List.hd in
    let username = post_param "username"
    and password = post_param "password"
    and id = post_param "id" |> int_of_string
    and resolution = post_param "solution" in
    Db.archive ~id ~resolution ~username ~password;
    redirect' (Uri.of_string "/tickets/")
  end

let tickets_page = get "/tickets/" begin fun req ->
    let row_of_ticket ticket =
      let link = "/ticket/" ^ string_of_int ticket.id in
      "<tr><td>"  ^ string_of_int ticket.id ^
      "</td><td>" ^ ticket.name ^
	    "</td><td>" ^ ticket.issue ^
      "</td><td>" ^ format_time ticket.timestamp ^
      "</td><td>" ^ ticket.assigned ^
      "</td><td><a href='" ^ link ^ "'>...</a></td></tr>" in
    let tickets = Db.get_tickets () in
    let page = Printf.sprintf [%blob "../template/tickets.html"]
      config.school_name config.school_name config.school_name
      "Open Tickets" "Close"
      (List.map row_of_ticket tickets |> String.concat "") in
    `String page |> respond'
  end

let archive_page = get "/archive/" begin fun req ->
    let row_of_ticket ticket =
      "<tr><td>"  ^ string_of_int ticket.id ^
      "</td><td>" ^ ticket.name ^
	    "</td><td>" ^ ticket.issue ^
      "</td><td>" ^ format_time ticket.timestamp ^
      "</td><td>" ^ ticket.assigned ^
      "</td><td>" ^ ticket.resolution ^ "</td></tr>" in
    let tickets = Db.get_archive () in
    let page = Printf.sprintf [%blob "../template/tickets.html"]
      config.school_name config.school_name config.school_name "Archived Tickets" 
      "Resolution" (List.map row_of_ticket tickets |> String.concat "") in
    `String page |> respond'
  end

let submit_ticket = post "/submit/" begin fun req ->
    App.urlencoded_pairs_of_body req >>= fun params ->
    let post_param name = List.assoc name params |> List.hd in
    let name = post_param "name"
    and issue = post_param "issue"
    and timestamp = string_of_float @@ Unix.time ()
    and assigned = post_param "assigned" in
    Db.put_ticket ~name ~issue ~timestamp ~assigned;
    let open Lwt in
    begin match config.mail_server with
      | Some host ->
        begin match Db.get_user ~username:assigned with
          | Some (_, _, email) ->
            Mail.send_reminder ~host ~email ~name ~issue >>= const (return ())
          | None -> return ()
        end
      | None -> return ()
    end >>= const (redirect' (Uri.of_string "/"))
  end

let index = get "/" begin fun req ->
    let users = Db.get_users () in
    let option_of_user (u, f, l) =
      Printf.sprintf "<option value=\"%s\">%s %s</option>" u f l in
    let options = List.map option_of_user users |> String.concat "" in
    let page = Printf.sprintf [%blob "../template/index.html"]
      config.school_name config.school_name config.school_name options in
    `String page |> respond'
  end

let app =
  for i = 1 to config.num_admins do
    Db.create_signup_code ()
  done;
  let static = Middleware.static ~local_path:"/var/kiosk/static" ~uri_prefix:"/static" in (* ./ because from exe directory *)
  App.empty
  |> index
  |> new_user
  |> signup
  |> ticket_page
  |> close_ticket_page
  |> tickets_page
  |> archive_page
  |> submit_ticket
  |> middleware static

let () = App.run_command app
