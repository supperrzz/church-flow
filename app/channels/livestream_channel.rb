class LivestreamChannel < ApplicationCable::Channel
  def subscribed
    stream_from "livestream_channel_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
