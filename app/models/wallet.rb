class Wallet < ApplicationRecord
  belongs_to :entity, polymorphic: true
  before_save :create_transaction

  private
  def create_transaction
    credit = CreditTransaction.new(amount: self.amount)
    credit.source_wallet = self

    credit.save!

  end
end
