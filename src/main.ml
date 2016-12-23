open Lwt
open Batteries
open Opium.Std

open UserData

let new_user = post "/new/" begin fun req ->
    App.urlencoded_pairs_of_body req >>= fun params ->
    let post_param name = List.assoc name params |> List.hd in
    let firstname = post_param "firstname"
    and lastname  = post_param "lastname"
    and email     = post_param "email"
    and username  = post_param "username"
    and password  = post_param "password" in
    Db.new_user ~firstname ~lastname ~email ~username ~password;
    redirect' (Uri.of_string "/")
  end

let signup = get "/signup/" begin fun req ->
    `String [%blob "../static/signup.html"] |> respond'
  end

let tickets_page = get "/tickets/" begin fun req ->
    let row_of_ticket ticket =
      "<tr><td>"  ^ string_of_int ticket.id ^
      "</td><td>" ^ ticket.name ^
	    "</td><td>" ^ ticket.issue ^
      "</td><td>" ^ format_time ticket.timestamp ^
      "</td><td>" ^ ticket.assigned ^ "</td></tr>" in
    let tickets = Db.get_tickets () in
    let page = Printf.sprintf [%blob "../static/tickets.html"]
	    "Open Tickets"
      (List.map row_of_ticket tickets |> String.concat "") in
    `String page |> respond'
  end

let archive_page = get "/archive/" begin fun req ->
    let row_of_ticket ticket =
      "<tr><td>"  ^ string_of_int ticket.id ^
      "</td><td>" ^ ticket.name ^
	    "</td><td>" ^ ticket.issue ^
      "</td><td>" ^ format_time ticket.timestamp ^
      "</td><td>" ^ ticket.assigned ^ "</td></tr>" in
    let tickets = Db.get_archive () in
    let page = Printf.sprintf [%blob "../static/tickets.html"]
	    "Archived Tickets"
      (List.map row_of_ticket tickets |> String.concat "") in
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
    redirect' (Uri.of_string "/")
  end

let index = get "/" begin fun req ->
    let users = Db.get_users () in
    let option_of_user (u, f, l) =
      Printf.sprintf "<option value=\"%s\">%s %s</option>" u f l in
    let options = List.map option_of_user users |> String.concat "" in
    let page = Printf.sprintf [%blob "../static/index.html"] options in
    `String page |> respond'
  end

let app =
  let static = Middleware.static ~local_path:"./static" ~uri_prefix:"/static" in (* ./ because from exe directory *)
  App.empty
  |> index
  |> new_user
  |> signup
  |> tickets_page
  |> archive_page
  |> submit_ticket
  |> middleware static

let () = App.run_command app
