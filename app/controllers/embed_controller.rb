class EmbedController < ApplicationController
  layout 'embed'
  after_action :allow_iframe

  def index
    @admin_live_stream = Admin::LiveStream.find_by embed_code: params[:embed_code]
  end

  private

  def allow_iframe
    # response.headers.except! 'X-Frame-Options'
    response.headers['X-FRAME-OPTIONS'] = 'ALLOW-FROM *'
  end
end
