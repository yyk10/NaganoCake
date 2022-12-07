class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?



  def after_sign_in_path_for(resource)
    return new_public_user_session_path if resource_or_scope == :public_user
    public_items_path(resource)
  end

  def after_sign_out_path_for(resource)
     return new_public_user_session_path if resource_or_scope == :public_user
   root_path
  end

 #before_action :authenticate_user!, except: [:login]

  def after_sign_in_path_for(resource_or_scope)
    return new_admin_user_session_path if resource_or_scope == :admin_user
    admin_root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    return new_admin_user_session_path if resource_or_scope == :admin_user
    new_admin_session_path
  end

 protect_from_forgery with: :exception

  helper_method :current_order

  def current_order
    if current_customer
      # ユーザーとカートの紐付け
      current_order = current_customer.order || current_customer.create_order!
    else
      # セッションとカートの紐付け
      current_order = Order.find_by(id: session[:order_id]) || Order.create
      session[:order_id] ||= current_order.id
    end
    current_order
  end

  protected

  def configure_permitted_parameters
    added_attrs = [ :email, :encrypted_password, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number]
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :encrypted_password, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
  end
end

