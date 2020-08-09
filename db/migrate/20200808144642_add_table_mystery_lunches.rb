class AddTableMysteryLunches < ActiveRecord::Migration[6.0]
  def change
    create_table :mystery_lunches do |t|
      t.integer :lunch_date_id
 
      t.timestamps
    end
  end
end
