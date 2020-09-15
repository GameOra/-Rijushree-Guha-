class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      if Role.pluck(:name).include?(user.roles.first.try(:name))
        send("#{user.roles.first.name}_abilities")
      else
        guest_abilities
      e