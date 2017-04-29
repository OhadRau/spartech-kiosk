type config = {
  school_name : string;
  school_logo : string;
  num_admins : int;
  gen_admin_keys : bool;
  mail_server : string option
}

let get_config file =
  let json = Yojson.Basic.from_file file in
  let open Yojson.Basic.Util in
  {
    school_name = json |> member "school-name" |> to_string;
    school_logo = json |> member "school-logo" |> to_string;
    num_admins = json |> member "num-admins" |> to_int;
    gen_admin_keys = json |> member "gen-admin-keys" |> to_bool;
    mail_server = match json |> member "use-email" |> to_bool with
      | true -> Some (json |> member "mail-server" |> to_string)
      | false -> None
  }
