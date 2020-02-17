FactoryGirl.define do
  factory :room do
    name 'Sala1'
  end

  factory :message do
    text 'texto'
    author 'autor'
    room_id 'id'
  end
end
