FactoryGirl.define do
  factory :room do
    name 'Sala ' + Faker::Name.first_name
  end

  factory :message do
    text Faker::Lorem.sentence
    author Faker::Name.first_name

    after :build do |m|
      if m.room_id.blank?
        room = build(:room)
        room.save
        m.room_id = room.id
      end
    end
  end
end
