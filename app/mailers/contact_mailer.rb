require 'mailgun'

class ContactMailer < ApplicationMailer
  default from: 'oedosproject@gmail.com'

  def submit(fullname, email, subject, body)
    mg_client = Mailgun::Client.new 'key-9daa213cdd6cec1de0e4a8e279e17696'
    message_params = {
      :from => "#{fullname} <postmaster@sandbox0a89f84c7faf43aead8c7df561124480.mailgun.org>",
      :to => "oedosproject@gmail.com",
      :subject => "#{subject}",
      :html => 
      "<p><strong>Name:</strong> #{fullname}</p>
      <p><strong>Email:</strong> #{email}</p>
      <p><strong>Subject:</strong> #{subject}</p>
      <p><strong>Body:</strong> <p>#{body}</p>"
    }
    mg_client.send_message 'www.spanishetym.com', message_params

  end




end
