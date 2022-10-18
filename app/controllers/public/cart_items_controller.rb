class Public::CartItemsController < ApplicationController
  def index
     @cart_item = CartItem.new
     @cart_items = CartItem.all
  end

  def create
     @customer = current_customer
     @cart_item = CartItem.new(params[:id])
     @item = Item.find(cart_item_params[:item_id])

     #@cart_item = Cart_item.new(cart_item_params[:item_id])
      #@item.admin_id = current_admin.id
     # @admin = @item.admin
     # @genre = @item.genre_id
    if @cart_item.save
       flash[:notice] = "Item was successfully created"
       redirect_to public_cart_item_path(@item.id)
    else
      @cart_items = CartItem.all
      render :index
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.update (item_params)
    redirect_to admin_item_path(@item.id), notice: 'Item information updated successfully'
    #else
  end

   private

  def cart_item_params
     params.require(:cart_item).permit(:item_id, :amount)
  end
end
