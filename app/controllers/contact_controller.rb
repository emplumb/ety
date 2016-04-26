class ContactController < ApplicationController

  def submit_message
    ContactMailer.submit(params[:firstname] + " " + params[:lastname], params[:email], params[:subject], params[:body]).deliver_now
    redirect_to root_path, :notice => "Thanks for your email! Your message has been received."

  end




end
