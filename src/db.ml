open UserData

open Batteries
open Gensqlite_tools

let db = Sqlite3.db_open "data/tickets.db"

module Raw = struct
  let (_, get_tickets) = [%gensqlite db "SELECT @d{ROWID}, @s{name}, @s{issue}, @f{timestamp} FROM tickets"]
  let (_, get_archive) = [%gensqlite db "SELECT @d{ROWID}, @s{name}, @s{issue}, @f{timestamp} FROM archive"]
  
  let (_, put_ticket)  = [%gensqlite db "INSERT INTO tickets (name, issue, timestamp) VALUES (%s{name}, %s{issue}, %s{timestamp})"]
  
  let (_, archive_ticket) = [%gensqlite db "INSERT INTO archive SELECT * FROM tickets WHERE ROWID = %d{rowid}"]
  let (_, purge_archived) = [%gensqlite db "DELETE FROM tickets WHERE ROWID = %d{rowid}"]
end

let get_tickets () =
  let tickets = Raw.get_tickets () in
  let create_ticket (id, name, issue, timestamp) =
    { id; name; issue; timestamp = timestamp |> float_of_string } in
  List.map create_ticket tickets
  
let get_archive () =
  let tickets = Raw.get_archive () in
  let create_ticket (id, name, issue, timestamp) =
    { id; name; issue; timestamp = timestamp |> float_of_string } in
  List.map create_ticket tickets

let archive ~id =
  let rowid = id in
  Raw.archive_ticket ~rowid ();
  Raw.purge_archived ~rowid ()

let put_ticket ~name ~issue ~timestamp =
  Raw.put_ticket ~name ~issue ~timestamp ()
