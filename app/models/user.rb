# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :phone_number, :user_type, :address, :gender, presence: true
  enum user_type: { super_admin: 0, buyer: 1, seller: 2, admin: 3 }
  enum gender: { male: 'Male', female: 'Female', other: 'Other' }
  has_many :auctions, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :products, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy

  after_commit :add_default_image, on: %i[create update]
  validate :correct_image_type

  def add_default_image
    return if avatar.present?

    avatar.attach(io: File.open(Rails.root.join(*%w[app assets images default_profile.png])),
                  filename: 'default_image.png', content_type: 'image/png')
  end

  def correct_image_type
    if avatar.attached? && !avatar.content_type.in?(%w[image/jpeg image/png])
      errors.add(:avatar, 'must be a JPEG or PNG')
    elsif avatar.attached? == false
      errors.add(:avatar, 'required')
    end
  end
end
