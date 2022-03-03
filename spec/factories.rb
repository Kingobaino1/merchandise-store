FactoryBot.define do

factory :random_item, class: Item do
    code { Faker::Name.initials(number: 3) }
    name { Faker::Name.name  }
    price { Faker::Number.decimal(l_digits: 2) }
  end
end