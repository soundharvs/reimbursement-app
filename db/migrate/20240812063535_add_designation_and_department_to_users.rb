class AddDesignationAndDepartmentToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :designation, :string
    add_column :users, :department, :string
  end
end
