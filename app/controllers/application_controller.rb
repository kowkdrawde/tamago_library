class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  BRAND_NAME = "Tamago Library".freeze

  def meta_title(title)
    [title, BRAND_NAME].reject(&:empty?).join(' | ')
  end

  ## the below integrates existing User model by permitting its db columns
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_path #, notice: params[:user_id]
  end

  rescue_from ActionController::RoutingError, with: :not_found

  def not_found
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found}
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstname, :lastname, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :email, :password, :remember_me) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password) }
  end



end
