class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :first_name, :last_name, :phone_number, :user_type
  enum user_type: { admin: 0, buyer: 1, seller: 2 }
  has_many :auctions, foreign_key: 'seller_id'
  has_many :bids
  has_many :products, foreign_key: 'seller_id'

  after_commit :add_default_image, on: %i[create update]

  def add_default_image
    return if avatar.present?

    avatar.attach(io: File.open(Rails.root.join(*%w[app assets images default_profile.png])),
                 filename: 'default_image.png', content_type: 'image/png')
  end
end
