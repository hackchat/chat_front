class ApplicationController < ActionController::Base
  # protect_from_forgery
  include ApplicationHelper

  private

  def require_login
    Rails.logger session.inspect
    unless session[:user_token]
      redirect_to LOGIN_URL
    end
  end

end