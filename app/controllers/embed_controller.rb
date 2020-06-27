class EmbedController < ApplicationController
  layout 'embed'

  def index
    @admin_live_stream = Admin::LiveStream.find_by embed_code: params[:embed_code]
  end
end
