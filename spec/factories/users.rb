FactoryBot.define do
  factory :user do
    first_name { 'Igor' }
    last_name { 'Petrovski' }
    handle_name { 'ipetrovski3' }
    sequence(:mail) { |n| "tester#{n}@tester.com" }
    password { '123123' }
    password_confirmation { '123123' }
  end
end
