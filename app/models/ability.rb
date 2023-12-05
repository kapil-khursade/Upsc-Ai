class Ability
  include CanCan::Ability

  def initialize(current_admin_user)
    current_admin_user ||= AdminUser.new # guest user

    if current_admin_user.role == "admin"
      can :manage, :all
    else
      can :read, :all
    end
  end
end
