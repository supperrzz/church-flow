class Church < ApplicationRecord
  belongs_to :user
  has_many :news, :class_name => 'Admin::News'
  has_many :events, :class_name => 'Admin::Event'
  has_many :media_images, :class_name => 'Admin::MediaImage'
  has_many :media_sermons, :class_name => 'Admin::MediaSermon'
  has_one :website, :class_name => 'Admin::Website'

  has_one_attached :logo
end
