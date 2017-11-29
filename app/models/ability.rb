# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    case
      when user.role == 'admin'
        can :manage, :all
      when user.role == 'moderator'
        can :read, :all
        can :manage, Micropost
        can :manage, Comment
        can :manage, ChatRoom
        can :ban, User
        can %i[update destroy], User, id: user.id
      when user.role == 'member'
        can :read, :all
        can :create, ChatRoom
        can :create, Micropost
        can :create, Comment
        can %i[edit update destroy], Micropost, user_id: user.id
        can %i[update destroy], User, id: user.id
      else
        can :read, Micropost
    end
  end
end
