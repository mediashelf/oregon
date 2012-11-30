class Ability
  include CanCan::Ability
  include Hydra::Ability

  # Override user_groups to ensure we send the user to the role mapper, not the user id.  This is
  # necessary because we have "pseudo-roles" added to users based on non-db information"
  def user_groups()#user, session)
    return @user_groups if @user_groups

    @user_groups = @user.groups + default_user_groups
    @user_groups
  end

  def custom_permissions#(user, session)
    if @user.groups.include?("reviewer")
      can :review, Image
    end
  end
end
