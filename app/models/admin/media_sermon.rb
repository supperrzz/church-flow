# == Schema Information
#
# Table name: admin_media_sermons
#
#  id         :bigint           not null, primary key
#  scripture  :string
#  speaker    :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  church_id  :bigint           not null
#
# Indexes
#
#  index_admin_media_sermons_on_church_id  (church_id)
#
# Foreign Keys
#
#  fk_rails_...  (church_id => churches.id)
#
class Admin::MediaSermon < ApplicationRecord
  belongs_to :church

  has_one_attached :video
end
