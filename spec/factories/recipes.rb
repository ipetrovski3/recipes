FactoryBot.define do
  factory :recipe do
    user

    name { 'Grilled Pork Ribs' }

    factory :instructions do
      name { 'bla bla bla' }
    end

    factory :ingredient do
      name { 'bla' }
    end
  end
end
