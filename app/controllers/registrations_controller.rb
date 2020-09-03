
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