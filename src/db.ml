open UserData

open Batteries
open Gensqlite_tools

let db = Sqlite3.db_open "data/tickets.db"

module Raw = struct
  let (_, get_code) = [%gensqlite db "SELECT @d{used} FROM codes WHERE code=%s{code}"]
  let (_, put_code) = [%gensqlite db "INSERT INTO codes (code, used) VALUES (%s{code}, 0)"]
  let (_, use_code) = [%gensqlite db "UPDATE codes SET used = 1 WHERE code=%s{code}"]
  let (_, new_user) = [%gensqlite db "INSERT INTO users (firstname, lastname, email, username, password) VALUES \
                                      (%s{firstname}, %s{lastname}, %s{email}, %s{username}, %s{password})"]

  let (_, get_user) = [%gensqlite db "SELECT @s{firstname}, @s{lastname}, @s{email} FROM users WHERE username = %s{username}"]
  let (_, get_hash) = [%gensqlite db "SELECT @s{password} FROM users WHERE username = %s{username}"]
  let (_, get_users) = [%gensqlite db "SELECT @s{username}, @s{firstname}, @s{lastname} FROM users"]

  let (_, get_ticket) = [%gensqlite db "SELECT @s{name}, @s{issue}, @f{timestamp}, @s{assigned} FROM tickets WHERE ROWID=%d{id}"]
  let (_, get_tickets) = [%gensqlite db "SELECT @d{ROWID}, @s{name}, @s{issue}, @f{timestamp}, @s{assigned} FROM tickets"]
  let (_, get_archive) = [%gensqlite db "SELECT @d{ROWID}, @s{name}, @s{issue}, @f{timestamp}, @s{assigned}, @s{resolution} FROM archive"]
  let (_, get_user_tickets) = [%gensqlite db "SELECT @d{ROWID}, @s{name}, @s{issue}, @f{timestamp} FROM tickets WHERE assigned=%s{username}"]

  let (_, put_ticket)  = [%gensqlite db "INSERT INTO tickets (name, issue, timestamp, assigned) VALUES (%s{name}, %s{issue}, %s{timestamp}, %s{assigned})"]

  let (_, archive_ticket) = [%gensqlite db "INSERT INTO archive SELECT * FROM (SELECT * FROM tickets WHERE ROWID = %d{rowid}) AS ticket, (SELECT %s{resolution} AS resolution) AS resolution"]
  let (_, purge_archived) = [%gensqlite db "DELETE FROM tickets WHERE ROWID = %d{rowid}"]
end

let create_signup_code () =
  Random.self_init ();
  let code = Int64.(Random.int64 max_int |> to_string) in
  try
    Raw.put_code ~code ();
    Printf.printf "New sign-up code: %s \n%!" code
  with _ -> print_endline "Could not create a unique sign-up code!"

let new_user ~firstname ~lastname ~email ~username ~password ~code =
  let code_used = Raw.get_code ~code () in
  match code_used with
  | [0] ->
    Raw.use_code ~code ();
    let hashed = Bcrypt.(hash password |> string_of_hash) in
    Raw.new_user ~firstname ~lastname ~email ~username ~password:hashed ();
    true
  | _ -> false

let get_user ~username =
  match Raw.get_user ~username () with
  | [] -> None
  | u::_ -> Some u

let get_users = Raw.get_users

let verify ~username ~password f =
  match Raw.get_hash ~username () with
  | [] -> ()
  | h::_ ->
    if Bcrypt.verify password (Bcrypt.hash_of_string h)
      then f ()
      else ()

let get_ticket ~id =
  match Raw.get_ticket ~id () with
  | [] -> None
  | (name, issue, timestamp, assigned)::_ ->
    Some (name, issue, float_of_string timestamp, assigned)

let get_tickets () =
  let tickets = Raw.get_tickets () in
  let create_ticket (id, name, issue, timestamp, assigned) =
    let assigned = match get_user ~username:assigned with
      | None -> "N/A"
      | Some (first, last, _) -> first ^ " " ^ last in
    { id; name; issue; timestamp = float_of_string timestamp; assigned; resolution = "" } in
  List.map create_ticket tickets

let get_archive () =
  let tickets = Raw.get_archive () in
  let create_ticket (id, name, issue, timestamp, assigned, resolution) =
    let assigned = match get_user ~username:assigned with
      | None -> "N/A"
      | Some (first, last, _) -> first ^ " " ^ last in
    { id; name; issue; timestamp = float_of_string timestamp; assigned; resolution } in
  List.map create_ticket tickets

let archive ~id ~resolution ~username ~password =
  let rowid = id in
  verify ~username ~password begin fun () ->
    Raw.archive_ticket ~rowid ~resolution ();
    Raw.purge_archived ~rowid ()
  end

let put_ticket ~name ~issue ~timestamp ~assigned =
  Raw.put_ticket ~name ~issue ~timestamp ~assigned ()
