FactoryBot.define do
  factory :user do
    sequence :name {|i| "Yay User #{i}" }
    sequence :email {|i| "#{i}user@email.com"}
    password { 'default2password'}
    role { 0 }
  end

  trait :with_addresses do
    transient do
      address_count { 1 }
    end

    after(:create) do |user, evaluator|
      user.addresses << create_list(:address, evaluator.address_count)
    end
  end

  trait :with_orders do
    transient do
      order_count { 1 }
    end

    after(:create) do |user, evaluator|
      user.orders << create_list(:order, evaluator.order_count)
    end
  end

  FactoryBot.rewind_sequences
end
