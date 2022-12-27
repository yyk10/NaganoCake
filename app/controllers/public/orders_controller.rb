class Public::OrdersController < ApplicationController
  def new
  @order = Order.new
  @customer = current_customer
  @addresses = current_customer.addresses
  end

  def create
   cart_items = current_customer.cart_items.all
   @order = current_customer.orders.new(order_params)

  if @order.save

    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      order_detail = OrderDetail.new(order_id: @order.id)
      order_detail.price = cart_item.item.price
      order_detail.amount = cart_item.amount
      order_detail.item_id = cart_item.item_id
      order_detail.making_status = 0
     # order_detail.item_id = cart.item_id
      #order_detail.order_id = @order.id
      #order_detail.order_quantity = cart.quantity

      #order_detail.order_price = cart.item.price

      order_detail.save
    end
    cart_items.destroy_all
    redirect_to public_orders_complete_path

  else
    render :new
  end
  end

def confirm

  @cart_items = current_customer.cart_items
  @order = Order.new(order_params)
  @order.customer_id = current_customer.id

  @total_price = current_customer.cart_items.cart_items_total_price(@cart_items)

  if params[:order][:select_address] == "1"
    @order.address = current_customer.address
    @order.postal_code = current_customer.postal_code
    @order.name = current_customer.first_name + current_customer.last_name

  elsif params[:order][:select_address] == "2"

     @order.postal_code = params[:order][:postal_code]
     @order.name =  params[:order][:name]
     @order.address =  params[:order][:address]

  else
      render 'new'
  end

 end


  def index
     @orders = current_customer.orders.all.page(params[:page]).per(6).order('created_at DESC')
     @cart_items = CartItem.where(customer_id: current_customer.id)
     @total_price = current_customer.cart_items.cart_items_total_price(@cart_items)

  end

  def show
   @order = Order.find(params[:id])
   # @order_details = @order.order_details.all
  end

  def complete
  end

  private

  def order_params
   params.require(:order).permit(:customer_id, :name, :postal_code, :address, :price, :postage, :payment_method, :status)
  end

  def address_params
    params.require(:order).permit(:name, :address, :postal_code)
  end

end
