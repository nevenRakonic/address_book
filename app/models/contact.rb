class Contact < ApplicationRecord
  belongs_to :user
  has_many :contact_attributes, inverse_of: :contact, dependent: :destroy
  accepts_nested_attributes_for :contact_attributes, allow_destroy: true

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :first_name, :address, presence: true
end
