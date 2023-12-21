class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= AdminUser.new

    if current_user.role == "admin"
      can :manage, :all
    else
      can :read, ActiveAdmin::Page, name: 'Dashboard' if current_user.persisted?
      can :read, ActiveAdmin::Page, name: 'BuyToken' if current_user.persisted?
      can [:read, :create], Question, admin_user_id: current_user.id
      can [:read], PaymentDetail, admin_user_id: current_user.id
    end
  end
end
