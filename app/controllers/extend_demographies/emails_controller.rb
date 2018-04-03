module ExtendDemographies
  class EmailsController < ProtectForgeryApplication
    include ExtendDemographiesHelper
    before_action  :authenticate_user!
    before_action :set_extend_demography
    before_action :authorize

    before_action :set_email, only: [:show, :edit, :update, :destroy]
    before_action :set_breadcrumbs


    def show
      render :edit
    end


    def new
      @email = @extend_demography.emails.build
    end

    def create
      @email = Email.new(email_params)
      @email.extend_demography_id = @extend_demography.id
      if @email.save
        redirect_to @url_back
      else
        render :new
      end
    end

    def edit

    end

    def update
      respond_to do |format|
        if @email.update(email_params)
          format.html { redirect_to url_back, notice: 'Email was successfully updated.' }
          #  format.json { render :show, status: :ok, location: @email }
        else
          format.html { render :edit }
          format.json { render json: @email.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /identifications/1
    # DELETE /identifications/1.json
    def destroy
      @email.destroy
      respond_to do |format|
        format.html { redirect_to url_back, notice: 'Email was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
    private

    def set_email
      @email = @extend_demography.emails.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def set_breadcrumbs
      extend_demography_breadcrumb
      add_breadcrumb @email.email_address, extend_demographies_email_path(@extend_demography, @email) if @email
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

    def email_params
      params.require(:email).permit(Email.safe_attributes)
    end
  end
end
