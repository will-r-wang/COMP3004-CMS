class CoursesController < ApplicationController
  skip_before_action :authorized
  before_action :set_course, only: %i[ show edit update destroy register withdraw ]

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.teacher = current_user
    @course.semester = current_semester

    if @course.save
      flash[:notice] = "Course successfully created."
      redirect_to root_path
    else
      flash[:error] = @course.errors
      redirect_to new_course_path
    end
  end

  def register
    create_course_registration
  rescue
    flash[:error] = "Error creating course registration"
    redirect_to root_path
  else
    flash[:notice] = "Course #{@course.course_code} successfully registered. An admin will review your request shortly."
    redirect_to root_path
  end

  def withdraw
    course_registration = CourseRegistration.find_by!(status: "approved", user: current_user, course: @course)

    binding.pry
    if course_registration
      course_registration.update!(status: "withdrawn")
      flash[:notice] = "Course #{@course.course_code} successfully withdrawn."
      redirect_to root_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @course.destroy
    flash[:notice] = "Course successfully deleted."
    redirect_to root_path
  end

  private
  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:course_name, :course_code, :capacity)
  end

  def create_course_registration
    CourseRegistration.create!(status: "pending", user: current_user, course: @course)
  end
end