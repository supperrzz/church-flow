class CreateSermonFromMuxJob < ApplicationJob
  queue_as :default

  def perform(live_stream_id, url)
    live_stream = Admin::LiveStream.find_by id: live_stream_id
    return unless live_stream.present?

    title = "Untitled #{Time.now.strftime('%e %b %Y %l:%M %p')}"
    admin_media_sermon = live_stream.church.media_sermons.create(title: title, video_remote_url: url)
    return unless admin_media_sermon.persisted?

    obj = ThumbnailGenerate.new
    obj.create(admin_media_sermon)
    # sermon = live_stream.church.media_sermons.create(video_remote_url: url)
    # sermon.generate_hls_video
  end
end
