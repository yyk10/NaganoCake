class Item < ApplicationRecord

   validates :name, presence: true, length: { maximum: 50 }
   validates :introduction, presence: true, length: { maximum: 140 }
   validates :price, presence: true, length: { maximum: 30 }
   validates :is_active, presence: true

  belongs_to :genre
  has_many :cart_item, dependent: :destroy


  def add_tax_price
    (self.price  * 1.08).round
  end

	def total_price
		good.price * quantity
	end

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end


end
