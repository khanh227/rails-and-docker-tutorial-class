class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    @user = user || User.new

    case
    when user.admin?
      can :manage, :all
    when user.restaurant?
      restaurant_permissions
    when user.customer?
      customer_permissions
    else
      cannot :manage, :all
    end
  end

  private
    def restaurant_permissions
      can :crud, Product, user_id: @user.id
      can :read, CustomerOrder
      cannot :cancel, CustomerOrder
      can :crud, Category
      can :read, LunchOrder
      can :crud, Menu
    end

    def customer_permissions
      can :read, Product
      can %i[read cancel], CustomerOrder, user_id: @user.id
      can :read, Category
      cannot :crud, LunchOrder
      can :read, Menu
    end
end
