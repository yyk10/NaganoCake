class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    #@order_details = @order.order_details.all
    @order_detail = OrderDetail.where(customer_id: @order_details_id)
    @total_price = 0
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details
      if @order.status == "waiting_for_paymant"
      @order_details.each do |order_detail|
        order_detail.making_status = "waiting_for_production"
        order_detail.save
      end
      end
    redirect_to admin_order_path

  end

  private
  def order_params
   params.require(:order).permit(:customer_id, :name, :postal_code, :address, :price, :postage, :payment_method, :status)
  end
end
