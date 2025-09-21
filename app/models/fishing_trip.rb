class FishingTrip < ActiveRecord::Base
  belongs_to :spot, optional: true

  validates :date, presence: true
  validates :fish, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :end_time_after_start_time

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

  def duration_display
    return "Duration not recorded" unless start_time && end_time

    duration_minutes = ((end_time_seconds - start_time_seconds) / 60).round
    hours = duration_minutes / 60
    minutes = duration_minutes % 60

    if hours > 0
      "#{hours}h #{minutes}m"
    else
      "#{minutes}m"
    end
  end

  def has_time_range?
    start_time.present? && end_time.present?
  end

  private

  def end_time_after_start_time
    return unless start_time && end_time

    if end_time_seconds <= start_time_seconds
      errors.add(:end_time, "must be after start time")
    end
  end

  def start_time_seconds
    start_time.seconds_since_midnight
  end

  def end_time_seconds
    end_time.seconds_since_midnight
  end
end
