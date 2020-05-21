class Admin::Website < ApplicationRecord
  belongs_to :church

  has_one_attached :hero_image
end
