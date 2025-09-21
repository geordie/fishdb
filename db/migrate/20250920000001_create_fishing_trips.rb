class CreateFishingTrips < ActiveRecord::Migration[7.1]
  def change
    create_table :fishing_trips do |t|
      t.date :date, null: false
      t.integer :fish, null: false
      t.text :notes
      
      t.timestamps
    end
    
    add_index :fishing_trips, :date
  end
end
