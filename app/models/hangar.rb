
class Hangar < ApplicationRecord
  has_many :products

  validates :number, presence: true

  def sum_wieght
    sum = 0
    products.map { |product| sum = sum + product.items.sum(:total_wieght) }
    sum
  end
end