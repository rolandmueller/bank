class Transaction < ApplicationRecord
  belongs_to :account
  validates :amount, :description, :balance_after_transaction,
          presence: true
end
