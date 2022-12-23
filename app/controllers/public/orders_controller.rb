class Public::OrdersController < ApplicationController
  def new
  @order = Order.new
  @customer = current_customer
  end

  def create
   cart_items = current_customer.cart_items.all
   @order = current_customer.orders.new(order_params)
  if @order.save
    @cart_products = current_customer.cart_products
# ここに至るまでの間にチェックは済ませていますが、念の為IF文で分岐させています
    @cart_items.each do |cart_item|
# 取り出したカートアイテムの数繰り返します
# order_item にも一緒にデータを保存する必要があるのでここで保存します
      order_detail = OrderDetail.new(order_id: @order.id)
      order_detail.price = cart_item.item.price
      order_detail.amount = cart_item.amount
      order_detail.item_id = cart_item.item_id
     # order_detail.item_id = cart.item_id
      #order_detail.order_id = @order.id
      #order_detail.order_quantity = cart.quantity

      #order_detail.order_price = cart.item.price

      order_detail.save
    end
    @cart_items.destroy_all
    redirect_to public_orders_complete_path

# ユーザーに関連するカートのデータ(購入したデータ)をすべて削除します(カートを空にする)
  else
    render :new
  end
  end


# new 画面から渡ってきたデータをユーザーに確認してもらいます
def confirm
    
  @cart_items = current_customer.cart_items
  @order = Order.new(order_params)
  #binding.pry
  @total_price = current_customer.cart_items.cart_items_total_price(@cart_items)
  
  if params[:order][:address_number] == "1"
    @order.name = current_customer.first_name + " " + current_customer.last_name
    @order.address = current_customer.address
    @order.postal_code = current_customer.postal_code
   render 'confirm'

  elsif params[:order][:address_number] == "2"
   @address_new = current_customer.addresses.new(address_params)
   @address.address = params[:order][:address]
   @address.name = params[:order][:name]
   @address.postal_code = params[:order][:postal_code]
   @address.customer_id = current_customer.id
  if @address.save
   @order.postal_code = @address.postal_code
   @order.name = @address.name
   @order.address = @address.address
   render 'confirm'
  else
      render 'new'
# ここに渡ってくるデータはユーザーで新規追加してもらうので、入力不足の場合は new に戻します
  end
  end

  #@cart_items = current_customer.cart_items.all # カートアイテムの情報をユーザーに確認してもらうために使用します
  #@price = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
# 合計金額を出す処理です sum_price はモデルで定義したメソッドです
 end


  def index
     @orders = current_customer.orders.all.page(params[:page]).per(6).order('created_at DESC')
  end

  def show
   # @order = Order.find(params[:id])
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
