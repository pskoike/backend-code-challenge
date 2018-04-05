class Distance < ApplicationRecord
  validates :origin, presence: true
  validates :destination, presence: true
  validates :km, presence: true

  validates :km, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 100_000 }
end
