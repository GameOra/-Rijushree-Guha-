class Item < ApplicationRecord
  belongs_to :product

  before_save :calculate_total_wieght

  validates :quantity, presence: true
  validates_numericality_of :quantity, greater_than_or_equal_to: 0

  self.per_page = 10

  def add(amount)
    self.quantity = self.quantity.to_i + amount.to_i
  end

  def subtract(am