class ApplicationController < ActionController::Base
  # protect_from_forgery
  before_filter :require_login
  include ApplicationHelper

  private

  def require_login 
    unless session[:user_token]
      redirect_to LOGIN_URL
    end
  end

end