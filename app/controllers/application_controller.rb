class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?



  def after_sign_in_path_for(resource)
    public_items_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

 #before_action :authenticate_user!, except: [:login]


  protected

  def configure_permitted_parameters
    added_attrs = [ :email, :encrypted_password, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number]
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :encrypted_password, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
  end
end

