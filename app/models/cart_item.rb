class CartItem < ApplicationRecord

    belongs_to :item, optional: true
    belongs_to :customer, optional: true

    validates :amount, presence: true


def total_price
		line_items.to_a.sum { |item| item.total_price }
	end

end
