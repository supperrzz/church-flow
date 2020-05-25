# == Schema Information
#
# Table name: admin_websites
#
#  id            :bigint           not null, primary key
#  body_font     :integer
#  heading_font  :integer
#  primary_color :string
#  youtube_live  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  church_id     :bigint           not null
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

  has_one_attached :hero_image
end
