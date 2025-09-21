class AddSpotToFishingTrips < ActiveRecord::Migration[7.1]
  def change
    add_reference :fishing_trips, :spot, null: true, foreign_key: true
  end
end
