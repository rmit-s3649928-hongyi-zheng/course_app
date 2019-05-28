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
        format.html { redirect_to course_course_detail_path, notice: 'Course was successfully created.' }
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
        format.html { redirect_to course_course_detail_path, notice: 'Course was successfully updated.' }
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
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
      # GET /courses/1/locations 
    def locations
      @course = Course.find(params[:id]) 
      @locations = @course.locations
    end      
    
    # POST /courses/1/location_add?location_id=2
    def location_add
      #Convert ids from routing to objects
      @course = Course.find(params[:id])
      @location = Location.find(params[:location])
      unless @course.assign_to?(@location)
      #add location to list using << operator 
         @course.locations<< @location 
         flash[:notice] = 'Location was successfully added' 
      else 
         flash[:error] = 'Location was already added' 
      end 
      redirect_to action: "locations", id: @course
    end
    
    def location_remove
      #Convert ids from routing to object 
      @course = Course.find(params[:id]) 
      #get list of locations to remove from query string
      location_ids= params[:locations] 
      if location_ids.any? 
        location_ids.each do |location_id| 
          location = Location.find(location_id) 
          if @course.enrolled_in?(location)
            logger.info"Removing location #{location.id} from course "
            @course.locations.delete(location) 
            flash[:notice] = 'Location was successfully deleted'
          end 
        end 
      end
        redirect_to action: "locations", id: @course
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
      params.require(:course).permit(:name, :prerequisite,:description,:user_id,:category_id,location_ids:[])
    end
    
    
    
    

end
