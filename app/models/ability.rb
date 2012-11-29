class Ability
  include CanCan::Ability
  include Hydra::Ability

  # Override user_groups to ensure we send the user to the role mapper, not the user id.  This is
  # necessary because we have "pseudo-roles" added to users based on non-db information"
  def user_groups(user, session)
    return @user_groups if @user_groups
    @user_groups = user.groups + default_user_groups
    @user_groups << 'registered' unless (user.new_record? || @user_groups.include?('registered'))
    @user_groups
  end
end
