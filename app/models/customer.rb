class Customer < ApplicationRecord
  has_many :accounts
  has_many :transactions, through: :accounts
  validates :first_name, presence: true
  validates :last_name, presence: true
end
