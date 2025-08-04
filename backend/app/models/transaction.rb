class Transaction < ApplicationRecord
  validates :account_number, presence: true
  validates :account_holder, presence: true
  validates :amount, presence: true
  validates :transaction_date, presence: true
end
