FactoryBot.define do
  factory :address do
    sequence :address {|i| "#{i} Fake St." }
    city {"Denver"}
    state {"CO"}
    zip {555555}

    user
  end

  FactoryBot.rewind_sequences

end
