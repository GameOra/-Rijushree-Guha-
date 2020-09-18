class Item < ApplicationRecord
  belongs_to :product

  before_save :calculate_total_wieght

  validates :quantity, presence: true
  validates_numericality_of :quantity, greater_than_or_equal_to: 