# == Schema Information
#
# Table name: admin_events
#
#  id             :bigint           not null, primary key
#  address        :text
#  description    :text
#  end_datetime   :datetime
#  image_data     :text
#  link           :string
#  location       :string
#  name           :string
#  start_datetime :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  church_id      :bigint
#
# Indexes
#
#  index_admin_events_on_church_id  (church_id)
#
class Admin::Event < ApplicationRecord
  belongs_to :church

  validates_presence_of :name, :start_datetime, :end_datetime, :address, :description, :link, :location
  validates_length_of :location, maximum: 150
  # has_one_attached :image
  include ImageUploader::Attachment(:image)
end
