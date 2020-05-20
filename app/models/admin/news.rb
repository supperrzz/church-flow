class Admin::News < ApplicationRecord
  belongs_to :church

  validates_presence_of :title, :body
  has_one_attached :image
end
