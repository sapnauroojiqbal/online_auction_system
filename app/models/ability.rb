# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)

    if user.admin? || user.super_admin?
      can :manage, :all
    elsif user.seller?
      can :manage, Product, user_id: user.id
      can :create, Auction
      can :read, Auction
      can :manage, Auction, user_id: user.id
      can :read, Review
    elsif user.buyer?
      can :read, Product
      can :bid, Product
      can :create, Bid
      can :read, Bid
      can :manage, Bid
      can :read, Auction
      can :manage, Review, user_id: user.id
    end
  end
end

