class Admin::MediaSermonsController < Admin::AdminBaseController
  before_action :set_admin_media_sermon, only: [:show, :edit, :update, :destroy]

  # GET /admin/media_sermons
  # GET /admin/media_sermons.json
  def index
    @admin_media_sermons = current_user.church.media_sermons
  end

  # GET /admin/media_sermons/1
  def show; end

  # GET /admin/media_sermons/new
  def new
    @admin_media_sermon = current_user.church.media_sermons.new
  end

  # GET /admin/media_sermons/1/edit
  def edit; end

  # POST /admin/media_sermons
  def create
    @admin_media_sermon = current_user.church.media_sermons.new(admin_media_sermon_params)

    if @admin_media_sermon.save
      redirect_to @admin_media_sermon, notice: 'Media sermon was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/media_sermons/1
  def update
    if @admin_media_sermon.update(admin_media_sermon_params)
      redirect_to @admin_media_sermon, notice: 'Media sermon was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/media_sermons/1
  def destroy
    @admin_media_sermon.destroy
    redirect_to admin_media_sermons_url, notice: 'Media sermon was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_media_sermon
    @admin_media_sermon = current_user.church.media_sermons.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_media_sermon_params
    params.require(:admin_media_sermon).permit(:title, :speaker, :scripture, :church_id, :video)
  end
end
