class AddTableLunchPartners < ActiveRecord::Migration[6.0]
  def change
    create_table :lunch_partners do |t|
      t.integer :mystery_lunch_id
      t.integer :employee_id
 
      t.timestamps
    end
  end
end
