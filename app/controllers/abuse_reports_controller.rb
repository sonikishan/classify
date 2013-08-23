class AbuseReportsController < ApplicationController
  # GET /abuse_reports
  # GET /abuse_reports.json
  def index
    @abuse_reports = AbuseReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @abuse_reports }
    end
  end

  # GET /abuse_reports/1
  # GET /abuse_reports/1.json
  def show
    @abuse_report = AbuseReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @abuse_report }
    end
  end

  # GET /abuse_reports/new
  # GET /abuse_reports/new.json
  def new
    @abuse_report = AbuseReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @abuse_report }
    end
  end

  # GET /abuse_reports/1/edit
  def edit
    @abuse_report = AbuseReport.find(params[:id])
  end

  # POST /abuse_reports
  # POST /abuse_reports.json
  def create
    @abuse_report = AbuseReport.new(params[:abuse_report])

    respond_to do |format|
      if @abuse_report.save
        format.html { redirect_to @abuse_report, notice: 'Abuse report was successfully created.' }
        format.json { render json: @abuse_report, status: :created, location: @abuse_report }
      else
        format.html { render action: "new" }
        format.json { render json: @abuse_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /abuse_reports/1
  # PUT /abuse_reports/1.json
  def update
    @abuse_report = AbuseReport.find(params[:id])

    respond_to do |format|
      if @abuse_report.update_attributes(params[:abuse_report])
        format.html { redirect_to @abuse_report, notice: 'Abuse report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @abuse_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /abuse_reports/1
  # DELETE /abuse_reports/1.json
  def destroy
    @abuse_report = AbuseReport.find(params[:id])
    @abuse_report.destroy

    respond_to do |format|
      format.html { redirect_to abuse_reports_url }
      format.json { head :no_content }
    end
  end
end
