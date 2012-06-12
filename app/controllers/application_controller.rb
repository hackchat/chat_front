class ApplicationController < ActionController::Base
  # protect_from_forgery
  before_filter :require_login
  include ApplicationHelper

  private

  def require_login
    Rails.logger.error session.inspect
    unless session[:user_token]
      if Rails.env.production?
        redirect_to "http://login.hackchat.in"
      else
        redirect_to "http://localhost:4000/"
      end
    end
  end

end