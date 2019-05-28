class CourseController < ApplicationController
  def home
  end
  
  def course_detail
    if(params[:category_id] != nil)
      @category = Category.find_by_id(params[:category_id])
      @courses = @category.courses
    else if(params[:location_id] != nil)
      @location = Location.find_by_id(params[:location_id])
      @courses = @location.courses
    else
      @courses = Course.all
    end
    end
  end
  
  def coordinator_detail
    @users = User.all
  end
  
end
