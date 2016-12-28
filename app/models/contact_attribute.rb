class ContactAttribute < ApplicationRecord
  belongs_to :contact, inverse_of: :contact_attributes
  validates :name, :content, presence: true
end
