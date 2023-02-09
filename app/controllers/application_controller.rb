class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?





 #protect_from_forgery with: :exception

 # helper_method :current_order

  #def current_order
   # if current_customer
      # ユーザーとカートの紐付け
    #  current_order = current_customer.order || current_customer.create_order!
    #else
      # セッションとカートの紐付け
     # current_order = Order.find_by(id: session[:order_id]) || Order.create
      #session[:order_id] ||= current_order.id
    #end
    #current_order
  #end

  protected
 def after_sign_in_path_for(resource)
    if customer_signed_in?
        root_path#login後遷移path要変更確認用なので
    else
       admin_root_path #login後遷移path確認用なので要変更
    end
 end

  def after_sign_out_path_for(resource)
    if resource == :admin
       new_admin_session_path
    else
       root_path
    end

  end

 #before_action :authenticate_user!, except: [:login]


  def configure_permitted_parameters

    #added_attrs = [ :email, :encrypted_password, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number]
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
  end
end

