class ViewCountsController < ApplicationController
  # GET /view_counts
  # GET /view_counts.json
  def index
    @view_counts = ViewCount.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @view_counts }
    end
  end

  # GET /view_counts/1
  # GET /view_counts/1.json
  def show
    @view_count = ViewCount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @view_count }
    end
  end

  # GET /view_counts/new
  # GET /view_counts/new.json
  def new
    @view_count = ViewCount.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @view_count }
    end
  end

  # GET /view_counts/1/edit
  def edit
    @view_count = ViewCount.find(params[:id])
  end

  # POST /view_counts
  # POST /view_counts.json
  def create
    @view_count = ViewCount.new(params[:view_count])

    respond_to do |format|
      if @view_count.save
        format.html { redirect_to @view_count, notice: 'View count was successfully created.' }
        format.json { render json: @view_count, status: :created, location: @view_count }
      else
        format.html { render action: "new" }
        format.json { render json: @view_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /view_counts/1
  # PUT /view_counts/1.json
  def update
    @view_count = ViewCount.find(params[:id])

    respond_to do |format|
      if @view_count.update_attributes(params[:view_count])
        format.html { redirect_to @view_count, notice: 'View count was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @view_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /view_counts/1
  # DELETE /view_counts/1.json
  def destroy
    @view_count = ViewCount.find(params[:id])
    @view_count.destroy

    respond_to do |format|
      format.html { redirect_to view_counts_url }
      format.json { head :no_content }
    end
  end
end
