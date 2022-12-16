class Public::ItemsController < ApplicationController
  def index
     @item = Item.new
     @items = Item.page(params[:page])
     @cart_item = CartItem.new
  end

  def show
     @item = Item.find(params[:id])
     @cart_item = CartItem.new
  end

  private

  def item_params
   params.require(:item).permit(:name, :introduction, :price, :is_active, :profile_image, :genre_id)
  end

end
