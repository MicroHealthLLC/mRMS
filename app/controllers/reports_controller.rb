class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel
  before_action :set_report, only: [:share_report, :upload_document, :show, :edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    @reports = @channel.visible_reports
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new(user_id: User.current.id, channel_id: @channel.id)
  end

  # GET /reports/1/edit
  def edit
  end

  def upload_document
    if request.post?
      @report.document = params[:report][:document]
      @report.save
      redirect_to channel_report_path(@channel, @report)
    end
  end

  def share_report
    @shared_reports = @report.shared_reports.pluck(:user_id)
    @users = User.where.not(id: User.current.id)
    if request.post?
      @report.shared_reports.where(user_id: (@shared_reports.map(&:to_s) - params[:users]) ).where.not(user_id: User.current.id).delete_all
      (params[:users] - @shared_reports.map(&:to_s)).each do |user_id|
        @report.shared_reports.create(user_id: user_id)
      end
      flash[:notice] = "User(s) added successfully"
      redirect_to channel_report_path(@channel, @report)
    end
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to channel_report_path(@channel, @report), notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to channel_report_path(@channel, @report), notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to channel_path(@channel), notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_channel
    @channel = Channel.find(params[:channel_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def report_params
    params.require(:report).permit(:name, :category_id, :channel_id, :category_type_id, :user_id, :document)
  end
end