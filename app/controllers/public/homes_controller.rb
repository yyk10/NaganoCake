class Public::HomesController < ApplicationController
  def top
    @items = Item.all
    @item = Item.new
    @items = Item.page(params[:page])
  end

  def  add_tax_sales_price
  (self.sales_price * 1.10).round
　end

  def about
  end


  private

  def item_params
  params.require(:item).permit(:name, :introduction, :price, :is_active, :profile_image )
  end

  end
end
