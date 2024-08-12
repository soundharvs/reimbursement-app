class DepartmentsController < ApplicationController

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      flash[:notice] = "Department created"
    else
      flash[:error] = "Error while creating department!"
    end
  end

  private

  def department_params
    params.require(:department).permit(:name)
  end
end
