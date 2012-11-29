class ApplicationController < ActionController::Base
  # Adds a few additional behaviors into the application controller 
   include Blacklight::Controller  
# Adds Hydra behaviors into the application controller 
  include Hydra::Controller::ControllerBehavior

  # Please be sure to impelement current_user and user_session. Blacklight depends on 
  # these methods in order to perform user specific actions. 

  protect_from_forgery

  layout "blacklight"

  # Will this allow us to auto-add a group to non-logged-in users?
  def guest_user
    user = super
    user.current_sign_in_ip ||= request.env['REMOTE_ADDR']

    return user
  end
end
