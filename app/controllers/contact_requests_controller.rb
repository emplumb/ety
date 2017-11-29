class ContactRequestsController < ApplicationController

	def new
	  session[:antispam_time] = Time.now.to_i
	end

	def submit_message
		current_time = Time.now.to_i

    if current_time < session[:antispam_time] + 20.seconds.to_i
      logger.warn("Potential spam detected for IP #{request.env['REMOTE_ADDR']}. Contact form submitted in #{current_time - session[:antispam_time]}s.")
			
			flash[:danger] = 'Sorry, your message cannot be sent at this time. Please try again.'
			redirect_back(fallback_location: root_path)
    else
	    if !params[:fax].present?
				ContactMailer.submit(
					params[:firstname] + " " + params[:lastname], 
					params[:email], 
					params[:subject], 
					params[:body]
				).deliver_now

				flash[:success] = 'Thanks for your email! Your message has been received.'
				redirect_back(fallback_location: root_path)
			else
				flash[:danger] = 'Sorry, your message cannot be sent at this time. Please try again later.'
				redirect_back(fallback_location: root_path)
			end
    end
	end

end
