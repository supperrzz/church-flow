class Admin::MediaSermon < ApplicationRecord
  belongs_to :church

  has_one_attached :video
end
