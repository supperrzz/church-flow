# == Schema Information
#
# Table name: admin_media_sermons
#
#  id                :bigint           not null, primary key
#  hls_thumbnail_url :text
#  hls_url           :text
#  published         :boolean          default(FALSE)
#  scripture         :string
#  speaker           :string
#  title             :string
#  video_data        :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  church_id         :bigint           not null
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

  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }

  # has_one_attached :image
  include VideoUploader::Attachment(:video)

  def get_video_url
    hls_url || video.try(:url)
  end
end
