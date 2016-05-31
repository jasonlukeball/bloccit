class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper

  private

  def require_sign_in
    unless current_user
      flash[:alert] = "Sorry! You must be signed in to do that!"
      redirect_to new_session_path
    end
  end

end
