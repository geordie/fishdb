class FishingTrip < ActiveRecord::Base
  belongs_to :spot, optional: true

  validates :date, presence: true
  validates :fish, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :recent, -> { order(date: :desc) }
  scope :by_date, ->(date) { where(date: date) }
  scope :by_spot, ->(spot) { where(spot: spot) }

  def total_fish_display
    case fish
    when 0
      "No fish caught"
    when 1
      "1 fish caught"
    else
      "#{fish} fish caught"
    end
  end

  def spot_name
    spot&.name || "No spot selected"
  end
end
