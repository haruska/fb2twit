class UsersController < ApplicationController
  
  before_filter :get_user
  
  def index
  end
  
  def advanced
  end
  
  def update
    @user.update_attributes(params[:user])
    @user.update_attribute(:bad_pass, false) if @user.bad_pass?
    flash[:notice] = "Settings Updated"
    redirect_to :action => 'index'
  end
  
  protected
  
  def get_user
    fbuser = facebook_session.user
    @user = User.find_by_facebook_id(fbuser.to_i) || User.create(:facebook_id => fbuser.to_i)
    @user.update_attributes :session => facebook_session
  end
  
end
