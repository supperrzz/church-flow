require 'openssl'
require 'base64'

class NotifyController < ApplicationController
  skip_before_action :verify_authenticity_token
  # Events that can be triggered for live stream
  # video.live_stream.created
  # video.live_stream.connected
  # video.live_stream.recording
  # video.live_stream.active
  # video.live_stream.disconnected
  # video.live_stream.idle
  # video.live_stream.updated
  # video.live_stream.deleted
  #
  # For Simulcast
  # video.live_stream.simulcast_target.created
  # video.live_stream.simulcast_target.idle
  # video.live_stream.simulcast_target.starting
  # video.live_stream.simulcast_target.broadcasting
  # video.live_stream.simulcast_target.errored
  # video.live_stream.simulcast_target.deleted
  def mux
    puts params
    verify_mux_signature
    case params[:type]
    when 'video.live_stream.active'
      set_live_stream_status('active')
    when 'video.live_stream.idle'
      set_live_stream_status('idle')
    when 'video.live_stream.disconnected'
      set_live_stream_status('disconnected')
    when 'video.asset.static_renditions.ready'
      get_mp4_and_store_in_s3
    end
     # contains type of webhooks event https://docs.mux.com/docs/webhooks
    params[:id] # id of webhook event
    params[:created_at] # created at
    params[:environment] # environment contains name and id
    params[:object] # object info contains type and id
    params[:data] # The details of the specific object that triggered the event.
    render json: { success: 'Received Webhook' }
  end

  private

  def set_live_stream_status(status)
    mux_stream_id = params[:object][:id]
    live_stream = Admin::LiveStream.find_by mux_stream_id: mux_stream_id
    if live_stream.present?
      puts "\n\n\n\n############## Changed status of live stream #{live_stream.id} to #{status}\n\n\n\n"
      live_stream.update(status: status)
      subdomain = live_stream.church.user.subdomain
      if status == 'active'
        live_stream.update(playback_id: params[:data][:playback_ids][0][:id])
        # html_embed = render_to_string(partial: 'admin/live_streams/embed_code_partial',
        #                              locals: { playback_id: live_stream.playback_id })
        ActionCable.server.broadcast("livestream_channel_#{subdomain}",
                                     video: "https://stream.mux.com/#{live_stream.playback_id}.m3u8",
                                     poster: "https://image.mux.com/#{live_stream.playback_id}/thumbnail.jpg")
        # html_embed: html_embed)
      elsif status == 'idle'
        ActionCable.server.broadcast("livestream_channel_#{subdomain}", video: false)
      end
    else
      puts "\n\n\n\n############## live stream not found\n\n\n\n"
    end
  end

  def get_mp4_and_store_in_s3
    # {"type":"video.asset.static_renditions.ready",
    #   "request_id":null,
    #   "object":{
    #       "type":"asset",
    #       "id":"EUnIVx57TNhXfFzBGRzXNGfi5YDTICXZ7dZzIYz25Mg"
    #   },
    #   "id":"55ff3e16-c557-49eb-b7c3-99a62afe00b9",
    #   "environment":{"name":"Production","id":"fqbrh9"},
    #   "data":{
    #     "tracks":[{"type":"video","max_width":640,"max_height":400,"max_frame_rate":30,"id":"np9CsluXBnUwm1H8iPlMKSQpHVT3uZFkbsK7XrHBRp4"},{"type":"audio","max_channels":2,"max_channel_layout":"stereo","id":"01xk02TOzBQAzjz00uxnJI02vdkfR2LC8x3g56Ru302mOSZ8"}],
    #     "status":"ready",
    #     "static_renditions":{"status":"ready","files":[{"width":576,"name":"low.mp4","height":360,"filesize":1284970,"ext":"mp4","bitrate":233600},{"width":640,"name":"medium.mp4","height":400,"filesize":1220345,"ext":"mp4","bitrate":221848}]},
    #     "playback_ids":[{"policy":"public","id":"r1t92sPukNU9zPbg3d1EcGDwjHWW00VS02Rk2g7edHsuU"}],
    #     "passthrough":"8","mp4_support":"standard","max_stored_resolution":"SD","max_stored_frame_rate":30,"master_access":"none","live_stream_id":"NeVEgZu00GSpcAo2cJ1GpDrIYnBsbiwaqus64zZwLh3c","id":"EUnIVx57TNhXfFzBGRzXNGfi5YDTICXZ7dZzIYz25Mg","duration":43.509333,"created_at":1592504239,"aspect_ratio":"8:5"},"created_at":"2020-06-18T18:18:25.000000Z","attempts":[],"accessor_source":null,"accessor":null}
    object_id = params[:object][:id]
    live_stream = Admin::LiveStream.find_by id: params[:data][:passthrough]
    if live_stream.present?
      puts 'live stream present'
      playback_id = params[:data][:playback_ids][0][:id]
      puts "playback id #{playback_id}"

      files = params[:data][:static_renditions][:files].map { |file| file[:name] }
      url = "https://stream.mux.com/#{playback_id}/low.mp4"
      if files.include? 'high.mp4'
        url = "https://stream.mux.com/#{playback_id}/high.mp4"
      elsif files.include? 'medium.mp4'
        url = "https://stream.mux.com/#{playback_id}/medium.mp4"
      end
      sermon = live_stream.church.media_sermons.create(video_remote_url: url)
      sermon.generate_hls_video
    else
      puts 'live stream not present'
    end
  end

  def verify_mux_signature
    # TODO: Complete this implementation
    puts mux_header = request.headers['Mux-Signature']
    if mux_header
      timestamp, signature = mux_header.split(',')
      puts 'timestamp: ' + timestamp
      puts 'signature: ' + signature
      puts signed_payload = timestamp.gsub('t=', '') + '.' + request.raw_post
      puts hash = OpenSSL::HMAC.hexdigest('sha256', ENV['mux_secret'], signed_payload)
      puts expected_signature = Base64.encode64(hash)
      puts signature.gsub('v1=', '') == expected_signature
    else
      false
    end
  end
end
