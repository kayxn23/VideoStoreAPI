class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals
  # validates :id, presence: true
  validates :title, presence: true
  validates :release_date, presence: true

  #create method to subtract current inventory for each rental



end
