# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :challenge do
    name "MyString"
    description "MyText"
    points 1
  end
end
