
class RegistrationsController < Devise::RegistrationsController

  def create
    super do
      set_role(resource)
      resource.save
    end
  end

  def update
    super do
      set_role(resource)
      resource.save
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end

  def set_role(resource)
    resource.add_role(Role.find(params[:role]).name)
  end
end