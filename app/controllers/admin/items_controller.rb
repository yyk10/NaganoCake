class Admin::ItemsController < ApplicationController
  def index
    @item = Item.new
    @items = Item.page(params[:page])
    @admin = current_admin
  end

  def new
     @item = Item.new
  end

  def create
      @item = Item.new(item_params)
      #@item.admin_id = current_admin.id
     # @admin = @item.admin
     # @genre = @item.genre_id
   if @item.save
       flash[:notice] = "新しい商品を追加しました"
       redirect_to admin_item_path(@item.id)
   else
      @items = Item.all
      render :new
   end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    #@item.is_active = ActiveRecord::Type::Boolean.new.cast(item_params[:is_active])
    if @item.update!(item_params)
    flash[:update]  = "商品情報を編集しました."
    redirect_to admin_item_path(@item.id)
    else
    #if @item.update(item_params)
     #   redirect_to admin_item_path(@item.id)
    #else
    render 'show'
    end
  end

  private

 def item_params
  params.require(:item).permit(:name, :introduction, :price, :profile_image, :genre_id, :is_active )
 end
end
