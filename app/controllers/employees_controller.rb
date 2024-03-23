class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees (index action)
  def index
    # @employees = Employee.all
    @q = Employee.ransack(params[:q])
    @employees = @q.result(distinct: true)

    respond_to do |format|
      format.html
      format.csv do
        csv_data = CsvExportService.new(@employees).generate_csv
        send_data csv_data, filename: "employees-#{Date.today}.csv"
      end
    end
  end

  # GET /employees/:id (show action)
  def show
    @employee = Employee.find(params[:id])
  end

  # GET /employees/new (new action)
  def new
    @employee = Employee.new
  end

  # POST /employees (create action)
  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employees_path, notice: "Employee created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /employees/:id/edit (edit action)
  def edit
    @employee = Employee.find(params[:id])
  end

  # PATCH/PUT /employees/:id (update action)
  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      redirect_to employees_path, notice: "Employee updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /employees/:id (destroy action)
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to employees_path, notice: "Employee deleted successfully!"
  end

  private

  # Use callbacks to share common setup or constraints between actions
  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :contact_number, :address, :pincode, :city, :state, :date_of_birth, :date_of_hiring)
  end
end

