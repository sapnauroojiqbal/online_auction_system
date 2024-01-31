class Product < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :sold_to, class_name: 'User', optional: true
  has_one :review, dependent: :destroy

  enum status: { unapproved: 0, approved: 1, sold: 2, rejected: 3 }
end
