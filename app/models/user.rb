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
    remove_old_r