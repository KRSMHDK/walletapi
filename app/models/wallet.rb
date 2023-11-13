class Wallet < ApplicationRecord
  belongs_to :entity
  has_many :source_transactions, class_name: 'Transaction', foreign_key: 'source_wallet_id'
  has_many :target_transactions, class_name: 'Transaction', foreign_key: 'target_wallet_id'

  def balance
    credit = target_transactions.sum(:amount)
    debit = source_transactions.sum(:amount)

    credit - debit
  end
end
