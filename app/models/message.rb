class Message
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  # Fields

  field :text,    type: String
  field :author,  type: String

  # Validations

  validates :text,    presence: true, length: {maximum: 140}
  validates :author,  presence: true

  # Relations

  belongs_to :room, class_name: 'Room'

  # Scopes
  scope :from_room, ->(room_id) { where(room_id: room_id).order('created_at DESC') }

  def self.paginated_and_reversed(room_id, num_page=1, per_page=20)
    from_room(room_id).paginate(page: num_page, per_page: per_page).reverse
  end
end
