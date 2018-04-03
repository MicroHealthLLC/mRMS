module ExtendDemographies
  class PhonesController < ProtectForgeryApplication
    before_action  :authenticate_user!
    before_action :set_extend_demography
    before_action :authorize

    before_action :set_phone, only: [:show, :edit, :update, :destroy]
    before_action :set_breadcrumbs

    include ExtendDemographiesHelper

    def show
      render :edit
    end

    def new
      @phone = @extend_demography.phones.build
    end

    def create
      @phone = Phone.new(phone_params)
      @phone.extend_demography_id = @extend_demography.id
      if @phone.save
        redirect_to @url_back
      else
        render :new
      end
    end

    def edit

    end

    def update
      respond_to do |format|
        if @phone.update(phone_params)
          format.html { redirect_to url_back, notice: 'phone was successfully updated.' }
          #  format.json { render :show, status: :ok, location: @phone }
        else
          format.html { render :edit }
          format.json { render json: @phone.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /phones/1
    # DELETE /phones/1.json
    def destroy
      @phone.destroy
      respond_to do |format|
        format.html { redirect_to url_back, notice: 'phone was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
    private
    def set_phone
      @phone = @extend_demography.phones.find(params[:id])
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
      add_breadcrumb @phone.phone_number, extend_demographies_phone_path(@extend_demography, @phone) if @phone
    end

    def authorize
      true
    end

    def phone_params
      params.require(:phone).permit(Phone.safe_attributes)
    end

  end
end
