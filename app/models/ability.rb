# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :admin
      can :go_manage_system, 'control_center'
      can :manage, :all
    elsif user.has_role? :store_manager
      can :go_manage_system, 'control_center'
      can :read, Admin
      can :read, Store
      can :update, Store do |store|
        store.editable?(user)
      end
      can :manage, PreOrder, store_id: user.store_id
      can [:read, :update, :search, :export], User, store_id: user.store_id
    elsif user.has_role? :product_manager
      can :go_manage_system, 'control_center'
      can :read, Admin
      can :manage, [CarouselAd, SideBarAd, Telecommunication, Variant, Brand, Recovery, Product]
      can :create, PreOrder
    elsif user.has_role? :normal
      can :create, PreOrder
    end
  end
end
