class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.page(params[:page])
    @customer = Customer.new
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update (customer_params)
      flash[:success] = "Customer was successfully updated"
    redirect_to admin_customer_path
    #else
    #if @item.update(item_params)
     #   redirect_to admin_item_path(@item.id)
    else
    render :edit #, status: :unprocessable_entity
    end
  end
  private

 def customer_params
  params.require(:customer).permit(:email, :encrypted_password, :last_name, :first_name,
  :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_deleted)
 end
end
