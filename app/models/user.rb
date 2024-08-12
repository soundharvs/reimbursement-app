class User < ApplicationRecord
  enum role: { employee: 0, admin: 1 }

  has_many :bills

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validate :passwords_match, if: -> { password.present? || password_confirmation.present? }

  has_secure_password

  private

  def passwords_match
    if password.present? || password_confirmation.present?
      errors.add(:password_confirmation, "doesn't match Password") if password != password_confirmation
    end
  end
end
