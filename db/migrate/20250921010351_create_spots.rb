class CreateSpots < ActiveRecord::Migration[7.1]
  def change
    create_table :spots do |t|
      t.string :name, null: false
      t.string :location

      t.timestamps
    end

    add_index :spots, :name
  end
end
