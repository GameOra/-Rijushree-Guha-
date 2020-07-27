class Admin::BaseController < ApplicationController
  before_action :verify_admin

  private

  def verify_admin
    redirect_to root_url unless current_user.try(:has_role?, :admin)
  end
end
