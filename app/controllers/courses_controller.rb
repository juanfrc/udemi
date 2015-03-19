class CoursesController < ApplicationController

  before_filter :authenticate_user!

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

  def subscribe
  	user = current_user
  	course = Course.find(params[:course_id])
    user.courses << course
    redirect_to root_path
  end

  def unsubscribe
    user = current_user
    course = Course.find(params[:course_id])
    user.courses.delete(course)
    redirect_to root_path	
  end

  def teacher
    @mycourses = Course.where(owner_id: current_user.id)
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_teacher_path
  end

  private
  	def course_params
  		params.require(:course).permit(:name, :description, :owner_id)
  	end
end
