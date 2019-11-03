FactoryBot.define do
  factory :user do
    sequence :name {|i| "Yay User #{i}" }
  end

  trait :with_addresses do
    transient do
      address_count { 1 }
    end

    after(:create) do |user, evaluator|
      user.addresses << create_list(:address, evaluator.address_count)
    end
  end

  FactoryBot.rewind_sequences
end
