class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end

  def withdraw
    @customer = Customer.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update (customer_params)
    redirect_to public_customer_path(@customer.id), notice: 'Customer information updated successfully'
    #else
    #if @item.update(item_params)
     #   redirect_to admin_item_path(@item.id)
    #else
    #render :edit , status: :unprocessable_entity

  end


  private

 def customer_params
  params.require(:customer).permit(:email, :encrypted_password, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_deleted)
 end
end
