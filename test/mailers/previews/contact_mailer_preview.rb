# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  def sample_mail_preview
    ContactMailer.submit('fullname', 'email', 'subject', 'body')
  end

end
