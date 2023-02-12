
FactoryGirl.define do
  sequence :name do |n|
    "MyString#{n}"
  end

  factory :product do
    name
    wieght "9.99"
    hangar
  end

  factory :invalid_product, class: 'Product' do
    name nil
    wieght nil
    hangar nil
  end
end