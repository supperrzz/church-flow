class Admin::Event < ApplicationRecord
  belongs_to :church

  validates_presence_of :name, :start_datetime, :end_datetime, :address, :description, :link, :location
  validates_length_of :location, maximum: 150
  has_one_attached :image
end
