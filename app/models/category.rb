class Category < ApplicationRecord
 resourcify
 has_many :photos, dependent: :destroy
end
