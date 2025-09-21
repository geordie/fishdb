class Spot < ActiveRecord::Base
  has_many :fishing_trips, dependent: :nullify

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :description, length: { maximum: 500 }, allow_blank: true

  scope :by_name, -> { order(:name) }

  def trips_count
    fishing_trips.count
  end
end
