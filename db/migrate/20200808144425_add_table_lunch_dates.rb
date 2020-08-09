class AddTableLunchDates < ActiveRecord::Migration[6.0]
  def change
    create_table :lunch_dates do |t|
      t.date :date
 
      t.timestamps
    end
  end
end
