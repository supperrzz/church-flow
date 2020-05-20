class Church < ApplicationRecord
  belongs_to :user
  has_many :news, :class_name => 'Admin::News'
  has_many :events, :class_name => 'Admin::Event'

  has_one_attached :logo
end
