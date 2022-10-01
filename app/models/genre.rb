class Genre < ApplicationRecord
    belongs_to :admin

    has_many :item
end
