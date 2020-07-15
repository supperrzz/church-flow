class CreateSermonFromMuxJob < ApplicationJob
  queue_as :default

  def perform(live_stream_id, url)
    live_stream = Admin::LiveStream.find_by id: live_stream_id
    return unless live_stream.present?

    live_stream.church.media_sermons.create(video_remote_url: url)
    # sermon = live_stream.church.media_sermons.create(video_remote_url: url)
    # sermon.generate_hls_video
  end
end
