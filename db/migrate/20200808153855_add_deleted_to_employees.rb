class AddDeletedToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :available_for_lunch, :boolean, default: true
  end
end
