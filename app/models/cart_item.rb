class CartItem < ApplicationRecord

    belongs_to :item, optional: true
    belongs_to :customer, optional: true

    validates :amount, presence: true

end
