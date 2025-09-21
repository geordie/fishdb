class Spot < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :description, length: { maximum: 500 }, allow_blank: true

  scope :by_name, -> { order(:name) }
end
