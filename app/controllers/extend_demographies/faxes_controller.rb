module ExtendDemographies
  class FaxesController < ProtectForgeryApplication
    before_action  :authenticate_user!
    before_action :set_extend_demography
    before_action :authorize

    before_action :set_fax, only: [:show, :edit, :update, :destroy]
    before_action :set_breadcrumbs

    include ExtendDemographiesHelper

    def show
      render :edit
    end

    def new
      @faxe = @extend_demography.faxes.build
    end

    def create
      @faxe = Fax.new(fax_params)
      @faxe.extend_demography_id = @extend_demography.id
      if @faxe.save
        redirect_to @url_back
      else
        render :new
      end
    end

    def edit

    end

    def update
      respond_to do |format|
        if @faxe.update(fax_params)
          format.html { redirect_to url_back, notice: 'fax was successfully updated.' }
          #  format.json { render :show, status: :ok, location: @faxe }
        else
          format.html { render :edit }
          format.json { render json: @faxe.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /faxes/1
    # DELETE /faxes/1.json
    def destroy
      @faxe.destroy
      respond_to do |format|
        format.html { redirect_to url_back, notice: 'fax was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_fax
      @faxe = @extend_demography.faxes.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def set_breadcrumbs
      extend_demography_breadcrumb
      add_breadcrumb @faxe.fax_number, extend_demographies_fax_path(@extend_demography, @faxe) if @faxe
    end


    # Use callbacks to share common setup or constraints between actions.
    def set_extend_demography
      @extend_demography = ExtendDemography.find(params[:extend_demography_id])
      @url_back = url_back
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def authorize
      true
    end

    def fax_params
      params.require(:fax).permit(Fax.safe_attributes)
    end

  end
end
