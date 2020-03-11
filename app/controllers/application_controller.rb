class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :index_all

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:fullname, :username, :email, :photo,
               :coverimage, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:fullname, :username, :email, :photo,
               :coverimage, :password, :current_password)
    end
  end

  def index_all
    @users = User.order('id desc').limit(4)
  end
end
