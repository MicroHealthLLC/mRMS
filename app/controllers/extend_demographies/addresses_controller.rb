module ExtendDemographies
  class AddressesController < ProtectForgeryApplication
    before_action  :authenticate_user!
    before_action :set_extend_demography
    before_action :authorize

    before_action :set_address, only: [:show, :edit, :update, :destroy]
    before_action :set_breadcrumbs

    include ExtendDemographiesHelper

    def show
      render :edit
    end

    def new
      @address = @extend_demography.addresses.build
    end

    def create
      @address = Address.new(address_params)
      @address.extend_demography_id = @extend_demography.id
      if @address.save
        redirect_to @url_back
      else
        render :new
      end
    end

    def edit

    end

    def update
      respond_to do |format|
        if @address.update(address_params)
          format.html { redirect_to url_back, notice: 'Address was successfully updated.' }
          format.json { render :show, status: :ok, location: @address }
        else
          format.html { render :edit }
          format.json { render json: @address.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /identifications/1
    # DELETE /identifications/1.json
    def destroy
      @address.destroy
      respond_to do |format|
        format.html { redirect_to url_back, notice: 'Address was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_extend_demography
      @extend_demography = ExtendDemography.find(params[:extend_demography_id])
      @url_back = url_back
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def set_breadcrumbs
      extend_demography_breadcrumb
      add_breadcrumb @address.address, extend_demographies_address_path(@extend_demography, @address) if @address
    end

    def set_address
      @address = @extend_demography.addresses.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def authorize
      true
    end

    def address_params
      params.require(:address).permit(Address.safe_attributes)
    end

  end
end
