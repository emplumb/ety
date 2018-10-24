require 'mailgun'

class ContactMailer < ApplicationMailer
  default from: ENV['DOMAIN_EMAIL']

  def submit(fullname, email, subject, body)
    mg_client = Mailgun::Client.new(ENV['MAILGUN_API_KEY'])
    formatted_body = ActionController::Base.helpers.simple_format(body)

    message_params = 
    {
      :from => "#{fullname} <#{email}>",
      :to => ENV['DOMAIN_EMAIL'],
      :subject => "#{subject}",
      :html => "#{formatted_body}"
    }

    mg_client.send_message ENV['EMAIL_HOST'], message_params
  end
end
