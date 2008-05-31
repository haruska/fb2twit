# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '361d0ac7b486be246a1d6925efc8c3f4'
  
  #facebookr auth to facebook
  ensure_application_is_installed_by_facebook_user
end
