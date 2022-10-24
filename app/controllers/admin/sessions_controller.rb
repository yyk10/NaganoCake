# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
 before_action :configure_permitted_parameters, if: :devise_controller?
 skip_before_action :verify_authenticity_token

  #def after_sign_in_path_for(resource)
  #  admin_root_path
#  end

  #def after_sign_out_path_for(resource)
  #  new_admin_session_path
  #end





protected
  def after_sign_in_path_for#(resource)
    public_items_index_path
    #user_path(resource)
  end

  def after_sign_out_path_for#(resource)
   #public_homes_about_path
    root_path
  end

 # protected

  #def configure_permitted_parameters
  #  devise_parameter_sanitizer.permit(:sign_up, keys: [:passwords, :email])
  #end


  #before_action :configure_sign_in_params, only: [:create]

  #GET /resource/ sign_in
   #def new
    #super
   #end

   #POST /resource/ sign_in
   #def create
    # super
   #end

   #DELETE /resource/ sign_out
   #def destroy
    # super
   #end

   #protected

   #If you have extra params to permit, append them to the sanitizer.
   #def configure_sign_in_params
    # devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
   #end
end
