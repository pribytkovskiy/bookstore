class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all
    return unless user.persisted?

    can %i[index show update edit], :order
    can :manage, User, id: user.id
    can :manage, Order, user_id: user.id
    can :create, Comment
    return unless user.role == 'admin'

    can :read, ActiveAdmin::Page, namespace_name: :admin
    can :manage, :all
  end
end
