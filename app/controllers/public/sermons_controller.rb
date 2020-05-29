class Public::SermonsController < PublicController
  def index
    @sermons = @church.media_sermons
  end
end
