class AddStartTimeAndEndTimeToFishingTrips < ActiveRecord::Migration[7.1]
  def change
    add_column :fishing_trips, :start_time, :time
    add_column :fishing_trips, :end_time, :time
  end
end
