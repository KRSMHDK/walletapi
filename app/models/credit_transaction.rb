class CreditTransaction < Transaction
  before_validation :set_transaction_type, on: :create
  validates :target_wallet, presence: true

  private

  def set_transaction_type
    self.transaction_type = 'Credit'
  end
end
