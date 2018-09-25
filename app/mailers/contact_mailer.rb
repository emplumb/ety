require 'mailgun'

class ContactMailer < ApplicationMailer
  default from: 'oedosproject@gmail.com'

  def submit(fullname, email, subject, body)
    mg_client = Mailgun::Client.new("key-9daa213cdd6cec1de0e4a8e279e17696")
    formatted_body = ActionController::Base.helpers.simple_format(body)

    message_params = 
    {
      :from => "#{fullname} <#{email}>",
      :to => "oedosproject@gmail.com",
      :subject => "#{subject}",
      :html => "#{formatted_body}"
    }

    mg_client.send_message 'www.spanishetym.com', message_params
  end
end
