# frozen_string_literal: true

class Public::EventsController < PublicController
  def index
    @events = @church.events
  end

  def show
    @event = @church.events.find(params[:id])
  end
end
