class DebitTransaction < Transaction
  before_validation :set_transaction_type, on: :create
  validates :source_wallet, presence: true

  private

  def set_transaction_type
    self.transaction_type = 'Debit'
  end
end
