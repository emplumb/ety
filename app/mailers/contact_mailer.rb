require 'mailgun'

class ContactMailer < ApplicationMailer
  default from: 'oedosproject@gmail.com'

  def submit(fullname, email, subject, body)
    mg_client = Mailgun::Client.new 'key-9daa213cdd6cec1de0e4a8e279e17696'
    message_params = {
      :from => 'Mailgun Sandbox <postmaster@sandbox0a89f84c7faf43aead8c7df561124480.mailgun.org>',
      :to => "oedosproject@gmail.com",
      :subject => "#{subject}",
      :html => "<h4>Name:</h4><p>#{fullname}</p><h4>Email:</h4><p>#{email}</p><h4>Subject:</h4><p>#{subject}</p><h4>Body:</h4><p>#{body}</p>"
    }
    mg_client.send_message 'sandbox0a89f84c7faf43aead8c7df561124480.mailgun.org', message_params

  end




end
