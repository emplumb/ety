class ContactController < ApplicationController

  def submit_message
    ContactMailer.submit(params[:firstname] + " " + params[:lastname], params[:email], params[:subject], params[:body]).deliver_now
    redirect_to("/email_confirmation")
  end




end
