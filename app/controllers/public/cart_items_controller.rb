class Public::CartItemsController < ApplicationController
  def index
     @cart_item = CartItem.new
     @cart_items = CartItem.all
     @total_price = current_customer.cart_items.cart_items_total_price(@cart_items)
    # @item = Item.find(cart_item_params[:id])
  end

  def create
      @item = Item.find(cart_item_params[:item_id])
      @cart_item = current_customer.cart_items.new(cart_item_params)
    #if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
     # cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      #cart_item.amount += params[:cart_item][:amount].to_i
      #cart_product.save
     # redirect_to cart_items_path
    #elsif @cartitem.save!
     # redirect_to cart_items_path,notice:"カートに商品が入りました"
    #end
    
    
     #@cart_item = CartItem.new(cart_item_params)
      #@cart_item.customer_id = current_customer.id
      #@cart_items = current_customer.cart_items.all
      #@cart_items.each do |cart_item|
     #if cart_item.item_id == @cart_item.item_id
      # new_quantity = cart_item.quantity + @cart_item.quantity
       #cart_item.update_attribute(:quantity, new_quantity)
     #end
      # @cart_item.save
      # redirect_to public_cart_items_path,notice:"カートに商品が入りました"
     #end
  end

  def update
   @cart_item = CartItem.find(params[:id])
    if params[:cart_item][:amount] == "0"
      @cart_item.destroy
      redirect_to cart_items_path
    elsif @cart_item.update(amount: params[:cart_item][:amount])
      redirect_to cart_itemss_path
    else
      @cart_items = current_customer.cart_items
      @total_price = current_customer.cart_items.cart_items_total_price(@cart_items)
      render "cart_items/index"
    end
  end

  def destroy
   current_customer.cart_items.find(params[:id]).destroy
   redirect_to cart_items_path
  end

  def destroy_all
   current_customer.cart_items.destroy_all
   redirect_to cart_items_path
  end

  private

  def cart_item_params
     params.require(:cart_item).permit(:item_id, :amount)
  end
end

