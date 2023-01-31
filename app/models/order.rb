class Order < ApplicationRecord

  enum payment_method: { credit_card: 0, transfer: 1 }

  enum status: { waiting_for_paymant: 0, payment_confirmation: 1, production: 2, shipping_preparation: 3, shipped: 4 }

belongs_to :customer
has_many :order_details ,dependent: :destroy


 def self.order_total_price(orders)
    array = []
    orders.each do |order|
    array << order.item.price * order.amount
    end
    return (array.sum * 1.1).floor
 end

end
