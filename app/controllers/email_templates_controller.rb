class EmailTemplatesController < ApplicationController
  before_action :set_email_template, only: [:edit, :update, :destroy]
  before_action :require_admin
  # GET /email_templates
  # GET /email_templates.json
  def index
    @email_templates = EmailTemplate.all
  end

  # GET /email_templates/1
  # GET /email_templates/1.json
  def load_available_variables
    @available_variables = []
    if params[:model].present?
      model = EmailTemplate.models.detect{|v| v == params[:model]}
      if model
        @available_variables = model.constantize.available_variable
      end
    end
  end

  # GET /email_templates/new
  def new
    @email_template = EmailTemplate.default
  end

  # GET /email_templates/1/edit
  def edit
  end

  # POST /email_templates
  # POST /email_templates.json
  def create
    @email_template = EmailTemplate.new(email_template_params)

    respond_to do |format|
      if @email_template.save
        format.html { redirect_to email_templates_path, notice: 'Email template was successfully created.' }
        format.json { render :show, status: :created, location: @email_template }
      else
        format.html { render :new }
        format.json { render json: @email_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /email_templates/1
  # PATCH/PUT /email_templates/1.json
  def update
    respond_to do |format|
      if @email_template.update(email_template_params)
        format.html { redirect_to email_templates_path, notice: 'Email template was successfully updated.' }
        format.json { render :show, status: :ok, location: @email_template }
      else
        format.html { render :edit }
        format.json { render json: @email_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_templates/1
  # DELETE /email_templates/1.json
  def destroy
    @email_template.destroy
    respond_to do |format|
      format.html { redirect_to email_templates_url, notice: 'Email template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_template
      @email_template = EmailTemplate.find(params[:id])
    rescue
      render_404
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_template_params
      params.require(:email_template).permit(:header, :body, :footer, :model, :stylesheet)
    end
end
