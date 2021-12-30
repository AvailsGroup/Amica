# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user&.admin?
      can :access, :active_admin
      can :manage, :all
    end
  end
end