# frozen_string_literal: true

class Public::SermonsController < PublicController
  def index
    @sermons = @church.media_sermons.published
  end
end
