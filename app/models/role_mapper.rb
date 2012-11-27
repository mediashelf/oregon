# RoleMapper This is used by AccessControlsEnforcement to get users' Roles (used in access permissions)
# If you are using something like Shibboleth or LDAP to get users' Roles, you should override this Class.  
# Your override should include a Module that implements the same behaviors as Hydra::RoleMapperBehavior 
class RoleMapper
  def roles(uid)
    u = User.find_by_user_key(uid)
    return ["public"] unless u
    return u.groups
  end
end
