class OrderDetail < ApplicationRecord

  enum making_status: { cannot_be_manufactured: 0, waiting_for_production: 1, production: 2, completion_of_production: 3 }
  belongs_to :item
  belongs_to :order

   def subtotal
    item.with_tax_price * amount
   end

    def add_tax_price
    (self.price  * 1.1).round
    end

    def taxin_price
        price*1.1
    end

    def with_tax_price
     (price * 1.1).floor
    end
end
