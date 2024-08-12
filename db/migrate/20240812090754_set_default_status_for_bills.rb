class SetDefaultStatusForBills < ActiveRecord::Migration[7.2]
  def change
    change_column_default :bills, :status, 0
  end
end
