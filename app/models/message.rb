class Message
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  
  #Fields
  
  field :text,    type: String
  field :author,  type: String

  #Validations
  
  validates :text,    presence: true, length: { maximum: 140 }
  validates :author,  presence: true
  
  
  belongs_to :room, class_name: "Room"
end
