FactoryBot.define do
  factory :payment do
    association :loan
    amount { 20 }
    date { Date.current }
  end
end