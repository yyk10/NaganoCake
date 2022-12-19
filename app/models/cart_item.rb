class CartItem < ApplicationRecord

    belongs_to :item
    belongs_to :customer
   
    validates :amount, presence: true

   def sum_price # 実際に作成したサイトは税金も算出していたのでメソッドを記載していました
      item.taxin_price*amount
   end

   def subtotal
    item.with_tax_price * amount
   end

    def self.cart_items_total_price(cart_items)
    array = []
    cart_items.each do |cart_item|
      array << cart_item.item.price * cart_item.amount
    end
    return (array.sum * 1.1).floor
    end

    def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
   end
  
end
