class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :transactions

  validates :email, :password, :name, presence: true

  def set_role(role)
    role = Role.find(role).name
    self.add_role(role) unless self.has_role?(role)
    remove_old_role(role)
  end

  private

  def remove_old_role(role)
    old_role = self.roles.to_a.delete_if { |el|  el.name == role }.first.try(:name)
    self.remove_role(old_role) if old_role
  end
end
