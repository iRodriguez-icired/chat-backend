FactoryGirl.define do
  factory :room do
    name 'Sala1'
  end

  factory :message do
    text Faker::Lorem.sentence
    author Faker::Name.first_name
    room_id 'id'
  end
end
