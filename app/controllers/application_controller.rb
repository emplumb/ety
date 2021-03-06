class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :session_expired?, if: ->{ Rails.env.production? }
  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

  private
    def record_not_unique
      flash[:danger] = "You are attempting to save an entry with the same url (slug) as an existing one. Please check your records and choose a new name.

        <br />
        <br />

        Note: punctuation, spaces, parentheses, and other special characters are removed from the url when saving"
      redirect_back(fallback_location: root_path)
    end
end
