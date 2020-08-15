# frozen_string_literal: true

class Public::LiveStreamsController < PublicController
  def index
    @live_stream = @church.live_streams.find_by(status: 'active')
  end
end
