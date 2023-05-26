FactoryBot.define do
  factory :reservation do
    type { "" }
    code { "MyString" }
    start_date { "2023-05-25 19:05:54" }
    end_date { "2023-05-25 19:05:54" }
    nights { 1 }
    guests { 1 }
    adults { 1 }
    children { 1 }
    infants { 1 }
    status { 1 }
    currency { "MyString" }
    payout_price { 1.5 }
    security_price { 1.5 }
    total_price { 1.5 }
    guest { 1 }
  end
end
