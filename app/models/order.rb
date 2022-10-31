class Order < ApplicationRecord

  enum payment_method: { credit_card: 0, transfer: 1 }

  enum status: { waiting_for_paymant: 0, payment_confirmation: 1, production: 2, shipping_preparation: 3, shipped: 4 }

belongs_to :customer
has_many :order_details,dependent: :destroy
belongs_to :item

 def self.cart_items_total_price(cart_products)
    array = []
    cart_items.each do |cart_item|
      array << cart_item.item.price * cart_item.amount
    end
    return (array.sum * 1.1).floor
 end

end
