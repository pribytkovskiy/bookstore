class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :all
    can :create, [Address, Card, Comment, Order, OrderItem]
    return unless user.persisted?

    can :create, Comment
    can :read, Order, user_id: user.id
    can :manage, User, id: user.id
    return unless user.role == 'admin'
    
    can :read, ActiveAdmin::Page, namespace_name: :admin
    can :manage, :all
  end
end
