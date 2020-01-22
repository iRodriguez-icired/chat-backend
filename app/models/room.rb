class Room
  include Mongoid::Document
  
  #Fields
  field :name, type: String
  
  #Validations
  validates :name, presence: true, uniqueness: true
  
  #Relations
  has_many :messages, class_name: "Message"
end
