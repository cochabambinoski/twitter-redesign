class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :index_all

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:fullname, :username, :email, :photo, :coverimage, :password, :password_confirmation) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:fullname, :username, :email, :photo, :coverimage, :password, :current_password) }
    end
    
    def index_all
      @users = User.order('id desc').limit(3)
    end
end
