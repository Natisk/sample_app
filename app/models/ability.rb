class Ability
  include CanCan::Ability

  def initialize(user)

    case
    when user.nil? then can :read, Micropost
    when user.role == 'admin' then can :manage, :all
    when user.role == 'moderator'
      can :read, :all
      can :manage, Micropost
      can :manage, Comment
      can :manage, ChatRoom
      can :ban, User
      can [:update, :destroy], User, id: user.id
    when user.role == 'member'
      can :read, :all
      can :create, ChatRoom
      can :create, Micropost
      can :create, Comment
      can [:edit, :update, :destroy], Micropost, user_id: user.id
      can [:update, :destroy], User, id: user.id
    end
  end
end
