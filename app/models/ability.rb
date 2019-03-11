class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :all
    can :create, [Address, Card, Comment, Order, OrderItem]
    if user.persisted?
      can :create, Comment
      can :read, Order, user_id: user.id
      can :manage, User, id: user.id
      if user.role == 'admin'
        can :read, ActiveAdmin::Page, namespace_name: :admin
        can :manage, :all
      end
    end
  end
end
