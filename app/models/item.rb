class Item < ApplicationRecord
  belongs_to :product

  before_save :calculate_total_wieght

  validat