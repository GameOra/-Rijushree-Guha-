
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  respond_to :html

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to products_path, alert: exception.message }
    end
  end

  check_authorization unless: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    current_user.has_role?(:admin) ? admin_items_path : items_path
  end
end