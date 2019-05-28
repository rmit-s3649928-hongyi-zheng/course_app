class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @locations = Location.all
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = current_user.courses.build(course_params)
    respond_to do |format|
      if @course.save
        flash[:success] = 'Course was successfully created' 
        format.html { redirect_to course_course_detail_path }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        flash[:success] = 'Course was successfully updated' 
        format.html { redirect_to course_course_detail_path }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, success: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
      # GET /courses/1/locations 
    def locations
      @course = Course.find(params[:id]) 
      @locations = @course.locations
    end      
    
    def categories
      @course = Course.find(params[:id])
      @categories = @course.categories
    end     
    
    
    def vote
      @course = Course.find(params[:id])
      @vote = @course.votes.create(user_id: current_user.id,kind:1)
      if @vote.save
        flash.now[:success] = "thanks for voting!"
      else
        flash.now[:danger] = "Error!You have already voted!"
      end
      redirect_to(course_course_detail_path)

    end
    
    def down_vote
      @course = Course.find(params[:id])
      @course.votes.create(user_id: current_user.id,kind:-1)
      redirect_to(course_course_detail_path)
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :prerequisite,:description,:image,:user_id,category_ids:[],location_ids:[])
    end
    
    
    
    
    

end
