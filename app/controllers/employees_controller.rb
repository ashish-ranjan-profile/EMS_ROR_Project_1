class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employee, only: [ :show, :edit, :update, :destroy ]
def index
  query = params[:query].to_s.strip

  if query.present?

    q_like = "%#{query}%"
    q_job_title = "#{query}%"

    @employees = Employee
      .left_outer_joins(:documents)
      .where("
        CAST(employees.id AS TEXT) ILIKE :q
        OR CONCAT(employees.first_name, ' ', employees.last_name) ILIKE :q
        OR employees.email ILIKE :q
        OR employees.mobile_num ILIKE :q
        OR employees.job_title ILIKE :job_title
      ", q: q_like, job_title: q_job_title)
      .distinct
      .order(id: :desc)
      .page(params[:page]).per(10)
  else
    @employees = Employee.order(id: :desc).page(params[:page]).per(10)
  end

  respond_to do |format|
    format.html
    format.xlsx {
      response.headers["Content-Disposition"] = 'attachment; filename="employees.xlsx"'
    }
  end
end



  def new
    @employee = Employee.new
  end
  def edit
  end

  def show
  end

  def destroy
    if @employee.destroy
      redirect_to employees_path, notice: "Employee was deleted successfully."
    else
      redirect_to employees_path, alert: "Failed to delete employee."
    end
  end



   def update
    if @employee.update(employee_params)
      redirect_to employees_path, notice: "Employee was successfully updated."
    else
      flash[:alert] = "Employee updation failed."
      render :edit
    end
   end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employees_path, notice: "Employee was successfully created."
    else
      flash[:alert] = "Employee creation failed."
      render :new
    end
  end





  private

  def employee_params
    params.require(:employee).permit(
      :first_name, :last_name, :email, :mobile_num, :DOB, :job_title,
      :city, :state, :pincode, :address
    )
  end


  def set_employee
    @employee = Employee.find(params[:id])
  rescue ActiveRecord::RecordNotFound => error
      redirect_to employees_path, notice: error
  end
end
