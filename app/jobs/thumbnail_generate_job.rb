class ThumbnailGenerateJob < ApplicationJob
  queue_as :default

  def perform(admin_media_sermon_id)
    admin_media_sermon = Admin::MediaSermon.where(id: admin_media_sermon_id).first
    return if admin_media_sermon.blank? || admin_media_sermon.thumbnail.present? || admin_media_sermon.video.blank?

    thumbnail = "media_sermon#{admin_media_sermon.id}.jpeg"
    
    resp = system "ffmpeg -ss 00:00:05 -i '#{admin_media_sermon.video&.url(host: ENV['CLOUDFRONT_ASSETS_ENDPOINT'], public: true)}' -f image2 -vframes 1 '#{thumbnail}'"

    admin_media_sermon.update(thumbnail: File.open(thumbnail)) if resp
  end
end
