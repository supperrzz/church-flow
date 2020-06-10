class NotifyController < ApplicationController
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
    verify_mux_signature
    params[:type] # contains type of webhooks event https://docs.mux.com/docs/webhooks
    params[:id] # id of webhook event
    params[:created_at] # created at
    params[:environment] # environment contains name and id
    params[:object] # object info contains type and id
    params[:data] # The details of the specific object that triggered the event.
    render json: { success: 'Received Webhook' }
  end

  private

  def verify_mux_signature
    mux_header = request.headers['Mux-Signature']
    if mux_header
      timestamp, signature = mux_header.split(',')
      signed_payload = timestamp + '.' + params.as_json
      expected_signature = OpenSSL::HMAC.digest('sha256', ENV[:mux_secret], signed_payload)
      signature == expected_signature
    else
      false
    end
  end
end
