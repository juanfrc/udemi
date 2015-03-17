class CoursesController < ApplicationController
  def index
  	@courses = Course.all
  end

  def new
  	@course = Course.new
  end

  def create
  	@course = Course.new(course_params)
  	@course.owner_id = current_user.id

  	if @course.save
  		redirect_to root_path
  	else
  		render 'index'
  	end
  end


  private
  	def course_params
  		params.require(:course).permit(:name, :description, :owner_id)
  	end
end
