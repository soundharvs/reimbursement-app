class Bill < ApplicationRecord
  belongs_to :user
  belongs_to :submitted_by, class_name: 'User'

  enum bill_type: { food: 0, travel: 1, others: 2 }
  enum status: { pending: 0, approved: 1, rejected: 2 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :bill_type, presence: true
end