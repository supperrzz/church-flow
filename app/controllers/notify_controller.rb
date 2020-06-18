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
      live_stream.update(playback_id: params[:data][:playback_ids][0][:id]) if status == 'active'
    else
      puts "\n\n\n\n############## live stream not found\n\n\n\n"
    end
  end

  def verify_mux_signature
    # TODO: Complete this implementation
    puts mux_header = request.headers['Mux-Signature']
    if mux_header
      timestamp, signature = mux_header.split(',')
      puts 'timestamp: ' + timestamp
      puts 'signature: ' + signature
      puts signed_payload = timestamp.gsub('t=', '') + '.' + request.body.read
      puts hash = OpenSSL::HMAC.hexdigest('sha256', ENV['mux_secret'], signed_payload)
      puts expected_signature = Base64.encode64(hash)
      puts signature.gsub('v1=', '') == expected_signature
    else
      false
    end
  end
end
