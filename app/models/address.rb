class Address < ApplicationRecord
  belongs_to :customer
  
  validates :name, presence: true
  validates :address, presence: true
  validates :postal_code, presence: true, format: {with: /\A\d{7}\z/}, numericality: { only_integer: true }

  def order_ship
    self.postal_code + self.address + self.name
  end
end
