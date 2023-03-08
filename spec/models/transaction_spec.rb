require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:product) }

  it { should validate_presence_of(:transaction_date) }
  it { should validate_presence_of(:quantity) }
  it { should validate_numericality_of(:quantity) }
end
