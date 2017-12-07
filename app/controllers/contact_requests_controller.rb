class ContactRequestsController < ApplicationController

	def new
	  session[:antispam_time] = Time.now.to_i
	  @request = ContactRequest.new
	end

	def submit_message
		current_time = Time.now.to_i

    if current_time < session[:antispam_time] + 10.seconds.to_i
      logger.warn("Potential spam detected for IP #{request.env['REMOTE_ADDR']}. Contact form submitted in #{current_time - session[:antispam_time]}s.")
			
			flash[:danger] = 'Sorry, your message cannot be sent at this time. Please try again.'
			render 'new.html.erb'
    else
	    if !params[:fax].present?
	    	@request = ContactRequest.new(
		      first_name: params[:first_name],
		      last_name: params[:last_name], 
					email: params[:email], 
					subject: params[:subject], 
					body: params[:body]
		    )
		    if @request.save
					ContactMailer.submit(
						params[:first_name] + " " + params[:last_name], 
						params[:email], 
						params[:subject], 
						params[:body]
					).deliver_now

					flash[:success] = 'Thanks for your email! Your message has been received.'
					redirect_to "/contact"
				elsif @request.errors.any?
		      flash[:danger] = "Error: #{@request.errors.full_messages.join(", ")}"
		      render "new.html.erb"
				end
			else
				flash[:danger] = 'Sorry, your message cannot be sent at this time. Please try again.'
				render 'new.html.erb'
			end
    end
	end

end
