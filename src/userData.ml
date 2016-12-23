open Yojson.Safe

let format_time t =
  let open Unix in
  let time = gmtime t in
  let days = [| "Sunday"; "Monday"; "Tuesday"; "Wednesday"; "Thursday"; "Friday"; "Saturday" |]
  and months = [| "January"; "February"; "March"; "April"; "May"; "June"; "July"; "August"; "September"; "October"; "November"; "December" |] in
  Printf.sprintf "%s, %s %d, %d\n"
    days.(time.tm_wday)
    months.(time.tm_mon)
    time.tm_mday
    (time.tm_year + 1900)

type ticket = {
  id :  int;
  name : string;
  issue : string;
  timestamp : float;
  assigned : string
}

let ticket_of_json json =
  let rec get_field target = function
    | `Assoc (x::xs) when fst x = target -> snd x
    | `Assoc (x::xs) -> get_field target (`Assoc xs)
    | _ -> `Null in
  let string = function
    | `String s -> s
    | _ -> "" in
  let name = json |> get_field "name" |> string
  and issue = json |> get_field "issue" |> string
  and assigned = json |> get_field "assigned" |> string in
  { id = 0; name; issue; timestamp = Unix.time (); assigned }

let json_of_ticket {id; name; issue; timestamp; assigned} =
  `Assoc ["id", `Int id;
          "name", `String name;
          "issue", `String issue;
          "timestamp", `Float timestamp;
          "assigned", `String assigned]

let json_of_tickets tickets =
  `List (List.map json_of_ticket tickets)
