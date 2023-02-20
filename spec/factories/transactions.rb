
FactoryGirl.define do
  factory :transaction do
    transaction_date "2017-10-09 10:39:38"
    quantity 1
    user user
    product user
  end
end