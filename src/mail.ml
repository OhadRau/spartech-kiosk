open Lwt
module Addr = Smtp_lwt.Addr

module Mail = struct
  open Smtp_lwt

  type message = {
    subject: string;
    content_type : string;
    text : string
  }

  let html = "text/html"
  let plain = "text/plain"

  let create_message subject ?(content_type=plain) text =
    {subject; content_type; text}

  let body_of_message {subject; content_type; text} =
    "Subject: " ^ subject ^ "\r\n" ^
    "Content-Type: " ^ content_type ^ "; charset=\"UTF-8\"\r\n" ^
    text

  let sendmail ~message =
    let body = body_of_message message in
    sendmail ~body
end

let send_reminder ~email ~name ~issue ~host =
  let name = Unix.gethostname ()
  and from = Addr.of_string "noreply@spartech.kiosk"
  and to_  = Addr.of_string email in
  let subject = "New ticket from " ^ name in
  let message = Mail.create_message subject issue in
  Mail.sendmail ~host:host ~name ~from ~to_:[to_] ~message ()
