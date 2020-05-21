class Admin::WebsiteController < Admin::AdminBaseController
  def show
    @website = current_user.church.website
  end

  def edit
    @website = current_user.church.website || Admin::Website.new
  end

  def update
    @website = current_user.church.website
    unless @website.present?
      @website = Admin::Website.new(church: current_user.church)
    end
    if @website.update(website_params)
      redirect_to admin_website_show_path, notice: 'Saved website config.'
    else
      render 'admin/website/edit'
    end
  end

  private

  def website_params
    params.require(:admin_website).permit(:primary_color, :heading_font, :body_font, :youtube_live, :hero_image)
  end
end
