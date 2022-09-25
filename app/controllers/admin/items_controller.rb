class Admin::ItemsController < ApplicationController
  def index
    @item = Item.new
    @items = Item.all
    @admin = current_admin
  end

  def new
     @item = Item.new
  end

  def create
      @item = Item.new(item_params)
      @item.admin_id = current_admin.id
      @admin = @item.admin
   if @admin.save
       flash[:notice] = "Item was successfully created"
       redirect_to admin_item_path(@item.id)
   else
      @items = Item.all
      render :index
   end
  end

  def show
  end

  def edit
  end

  def update
  end

  private

 def item_params
  params.require(:item).permit(:name, :introduction, :price, :is_active)
 end
end
