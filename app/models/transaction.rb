class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :transaction_date, :quantity, presence: true
  validates_numericality_of :quantity
end
