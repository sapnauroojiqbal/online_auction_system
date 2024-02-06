class Product < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :sold_to, class_name: 'User', optional: true
  belongs_to :auction, optional: true
  has_one :review, dependent: :destroy
  has_many :bids, dependent: :destroy

  enum status: { unapproved: "unapproved", approved: "approved",live: "live", sold: "sold", rejected: "rejected" , delivered: "delivered"}

  has_many_attached :images, dependent: :destroy
  has_one_attached :preview_image, dependent: :destroy

  validates_presence_of :name, :description, :preview_image, :images
  validate :image_type
  validate :correct_image_type
  validates :minimum_bid_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def image_type
    if images.attached? == false
      errors.add(:images, "are missing!")
    end
    images.each do |image|
      if !image.content_type.in?(%('image/jpeg image/png image/jpg'))
        errors.add(:images, 'image type need to be a JPEG or PNG or JPG')
      end
    end
  end

  def correct_image_type
    if preview_image.attached? && !preview_image.content_type.in?(%w[image/jpeg image/png])
      errors.add(:preview_image, 'must be a JPEG or PNG')
    elsif preview_image.attached? == false
      errors.add(:preview_image, 'required')
    end
  end
end
