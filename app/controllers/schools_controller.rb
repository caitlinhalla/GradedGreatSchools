class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :edit, :update, :destroy]

  # GET /schools
  # GET /schools.json
  def index
   @schools = School.all
   @school = School.where(text: params[:text]).first
  end

  # GET /schools/1
  # GET /schools/1.json
  def show

  end

  # GET /schools/new
  def new
      @school = School.new
  end

  # GET /schools/1/edit
  def edit
  end

  # POST /schools
  # POST /schools.json
  def create
    find_school = School.where(text: params[:text]).first
    if find_school
      redirect_to school_path(find_school.id)
    else
      @school = School.new(text: params[:text], latitude: params[:latitude], longitude: params[:longitude])
      if @school.save
        redirect_to school_path(@school)
      else
        render :new
      end
    end
  end

  # PATCH/PUT /schools/1
  # PATCH/PUT /schools/1.json
  def update
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to schools_path, notice: 'School was successfully updated.' }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    @school.destroy
    respond_to do |format|
      format.html { redirect_to schools_path, notice: 'School was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:text, :latitude, :longitude)
    end
end
