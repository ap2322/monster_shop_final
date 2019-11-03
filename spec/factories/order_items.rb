FactoryBot.define do
  factory :order_item do
    price { 5.00 }
    quantity { 2 }
    fulfilled { false }
    order
    item
  end

end
