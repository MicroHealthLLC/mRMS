module ExtendDemographies
  class SocialMediaController < ProtectForgeryApplication
    before_action  :authenticate_user!
    before_action :set_extend_demography
    before_action :authorize

    before_action :set_social_medium, only: [:show, :edit, :update, :destroy]
    before_action :set_breadcrumbs

    include ExtendDemographiesHelper

    def show
      render :edit
    end

    def new
      @social_media = @extend_demography.social_media.build
    end

    def create
      @social_media = SocialMedium.new(social_media_params)
      @social_media.extend_demography_id = @extend_demography.id
      if @social_media.save
        redirect_to @url_back
      else
        render :new
      end
    end

    def edit

    end

    def update
      respond_to do |format|
        if @social_media.update(social_media_params)
          format.html { redirect_to url_back, notice: 'social media was successfully updated.' }
          #  format.json { render :show, status: :ok, location: @social_media }
        else
          format.html { render :edit }
          format.json { render json: @social_media.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /social_medias/1
    # DELETE /social_medias/1.json
    def destroy
      @social_media.destroy
      respond_to do |format|
        format.html { redirect_to url_back, notice: 'social media was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    def set_social_medium
      @social_media = @extend_demography.social_media.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_extend_demography
      @extend_demography = ExtendDemography.find(params[:extend_demography_id])
      @url_back = url_back
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def set_breadcrumbs
      extend_demography_breadcrumb
      add_breadcrumb @social_media.social_media_handle, extend_demographies_social_media_path(@extend_demography, @social_media) if @social_media
    end

    def authorize
      true
    end

    def social_media_params
      params.require(:social_medium).permit(SocialMedium.safe_attributes)
    end

  end
end
