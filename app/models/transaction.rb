class Transaction < ApplicationRecord
  TRANSACTION_TYPES = ['Credit', 'Debit'].freeze

  validates :transaction_type, presence: true, inclusion: { in: TRANSACTION_TYPES }
  validates :amount, presence: true, numericality: { greater_than: 0 }

  belongs_to :source_wallet, class_name: 'Wallet', foreign_key: 'source_wallet_id', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', foreign_key: 'target_wallet_id', optional: true

  scope :credits, -> { where(transaction_type: 'Credit') }
  scope :debits, -> { where(transaction_type: 'Debit') }

end
