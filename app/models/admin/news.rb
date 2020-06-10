# == Schema Information
#
# Table name: admin_news
#
#  id         :bigint           not null, primary key
#  body       :text
#  image_data :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  church_id  :bigint
#
# Indexes
#
#  index_admin_news_on_church_id  (church_id)
#
class Admin::News < ApplicationRecord
  belongs_to :church

  validates_presence_of :title, :body
  # has_one_attached :image
  include ImageUploader::Attachment(:image)
end
