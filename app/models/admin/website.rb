# == Schema Information
#
# Table name: admin_websites
#
#  id              :bigint           not null, primary key
#  body_font       :string
#  heading_font    :string
#  hero_image_data :text
#  primary_color   :string
#  youtube_live    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  church_id       :bigint           not null
#
# Indexes
#
#  index_admin_websites_on_church_id  (church_id)
#
# Foreign Keys
#
#  fk_rails_...  (church_id => churches.id)
#
class Admin::Website < ApplicationRecord
  belongs_to :church

  # has_one_attached :hero_image
  include ImageUploader::Attachment(:hero_image)

  validates_presence_of :body_font, :heading_font, :primary_color

  attr_accessor :subdomain
  validates_format_of :subdomain, with: /\A^[A-Za-z0-9]+\Z/i

  FONTS = {
    'Roboto': 'https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap',
    'Open Sans': 'https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap',
    'Merriweather': 'https://fonts.googleapis.com/css2?family=Merriweather:wght@400;700&display=swap'
  }.freeze
end
