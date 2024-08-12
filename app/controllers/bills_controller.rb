class BillsController < ApplicationController
  before_action :set_bill, only: [:update_status]
  before_action :require_admin, only: [:update_status, :admin_index]

  def index
    if current_user.admin?
      redirect_to admin_index_bills_path
    else
      @bills = current_user.bills
      @total_amount = @bills.sum(:amount)
      @total_approved = @bills.where(status: 'approved').sum(:amount)
    end
  end

  def admin_index
    @bills = Bill.all
    @total_amount = @bills.sum(:amount)
    @total_approved = @bills.where(status: 'approved').sum(:amount)
  end

  def new
    @bill = Bill.new
  end

  def create
    @bill = current_user.bills.build(bill_params)
    @bill.submitted_by = current_user
    if @bill.save
      redirect_to bills_path, notice: "Bill submitted successfully."
    else
      render :new
    end
  end

  def update_status
    @bill = Bill.find(params[:id])
    
    if @bill.update(status: params[:status])
      redirect_to admin_index_bills_path, notice: "Bill status updated successfully."
    else
      redirect_to admin_index_bills_path, alert: "Failed to update bill status."
    end
  end  

  # def approve
  #   if @bill.update(status: "approved")
  #     redirect_to admin_index_bills_path, notice: "Bill approved."
  #   else
  #     redirect_to admin_index_bills_path, alert: "Failed to approve bill."
  #   end
  # end

  # def reject
  #   if @bill.update(status: "rejected")
  #     redirect_to admin_index_bills_path, notice: "Bill rejected."
  #   else
  #     redirect_to admin_index_bills_path, alert: "Failed to reject bill."
  #   end
  # end

  private

  def set_bill
    @bill = Bill.find(params[:id])
  end

  def bill_params
    params.require(:bill).permit(:amount, :bill_type, :status)
  end

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied!"
    end
  end
end
