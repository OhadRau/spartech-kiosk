open Lwt
open Batteries
open Opium.Std

open UserData

let tickets_page = get "/tickets/" begin fun req ->
    let row_of_ticket ticket =
      "<tr><td>"  ^ string_of_int ticket.id ^
      "</td><td>" ^ ticket.name ^ 
	  "</td><td>" ^ ticket.issue ^
      "</td><td>" ^ format_time ticket.timestamp  ^ "</td></tr>" in
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
      "</td><td>" ^ format_time ticket.timestamp  ^ "</td></tr>" in
    let tickets = Db.get_tickets () in
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
    and timestamp = string_of_float @@ Unix.time () in
    Db.put_ticket ~name ~issue ~timestamp;
    redirect' (Uri.of_string "/")
  end

let index = get "/" begin fun req ->
    let page = [%blob "../static/index.html"] in
    `String page |> respond'
  end

let app =
  let static = Middleware.static ~local_path:"./static" ~uri_prefix:"/static" in (* ./ because from exe directory *)
  App.empty
  |> index
  |> tickets_page
  |> archive_page
  |> submit_ticket
  |> middleware static

let () = App.run_command app
