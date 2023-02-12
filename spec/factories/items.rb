FactoryGirl.define do
  factory :item do
    product
    total_wieght "9.99"
    quantity 1
  end

  factory :invalid_item, class: 'It