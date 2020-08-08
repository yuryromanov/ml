class AddTableEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :department_id, default: nil
 
      t.timestamps
    end
  end
end
