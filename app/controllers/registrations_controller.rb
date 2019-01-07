# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
    # Required so that authenticated users can access this page
    # instead of being redirected to new_user_session_path
    
    # For registration paths
    
    skip_before_action :require_no_authentication
  
    def new
      ensure_admin || return
      super
    end
  
    def create
      ensure_admin || return
      build_resource(sign_up_params)
      resource.save
      yield resource if block_given?
      redirect_to users_path
    end
  
    def after_sign_up_path_for(_resource)
      users_path
    end
  
    def after_inactive_sign_up_path_for(_resource)
      users_path
    end
  
    def update_resource(resource, params)
      resource.update_without_password(params)
    end
  
    private
  
    def ensure_admin
      redirect_to(new_user_session_path) && return unless user_signed_in?
      redirect_to(users_path) && return unless current_user.has_role? :admin
      true
    end

end
