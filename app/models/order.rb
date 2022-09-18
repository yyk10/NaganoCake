class Order < ApplicationRecord

  enum payment_method: { credit_card: 0, transfer: 1 }

  enum status: { waiting_for_paymant: 0, payment_confirmation: 1, production: 2, shipping_preparation: 3, shipped: 4 }

end
