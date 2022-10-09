class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.page(params[:page])
    @customer = Customer.new
  end

  def show
  end

  def edit
  end

  def update
  end

  private

 def customer_params
  params.require(:customer).permit(:email, :encrypted_password, :last_name, :first_name,
  :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_deleted)
 end
end
