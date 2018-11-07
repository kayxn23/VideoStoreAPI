class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals
  validates :title, presence: true
  validates :release_date, presence: true
  validates :overview, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :available_inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, on: :show 

end
