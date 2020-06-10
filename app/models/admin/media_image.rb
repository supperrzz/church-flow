# == Schema Information
#
# Table name: admin_media_images
#
#  id         :bigint           not null, primary key
#  caption    :string
#  image_data :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  church_id  :bigint           not null
#
# Indexes
#
#  index_admin_media_images_on_church_id  (church_id)
#
# Foreign Keys
#
#  fk_rails_...  (church_id => churches.id)
#
class Admin::MediaImage < ApplicationRecord
  belongs_to :church

  # has_one_attached :image
  include ImageUploader::Attachment(:image)
end
