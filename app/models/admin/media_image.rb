class Admin::MediaImage < ApplicationRecord
  belongs_to :church

  has_one_attached :image
end
