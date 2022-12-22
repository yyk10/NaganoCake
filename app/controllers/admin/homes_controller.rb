class Admin::HomesController < ApplicationController

  def top
    @order = Order.new(params[:id])
    
  end
  
  
private
  def order_params
   params.require(:order).permit(:customer_id, :name, :postal_code, :address, :price, :postage, :payment_method, :status)
  end

end
