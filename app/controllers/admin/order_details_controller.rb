class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    #byebug
    @order_details = @order.order_details
    @order_detail.update(order_detail_params)

   if @order_details.where(making_status: "production").count >= 1
      @order.status = "production"
      @order.save
   end

   if @order.order_details.count == @order_details.where(making_status: "completion_of_production").count
       @order.status = "shipping_preparation"
       @order.save
   end
    redirect_to admin_order_path(order_detail.order.id)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount, :making_status)
  end
end
