# frozen_string_literal: true

class Public::NewsController < PublicController
  def index
    @news = @church.news
  end

  def show
    @article = @church.news.find(params[:id])
  end
end
