FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

 