class TransactionService
  def initialize(args)
    @amount = args[:amount]
    @target_wallet_id = args[:target_wallet_id]
    @source_wallet_id = args[:source_wallet_id]
  end

  def deposit
    CreditTransaction.create(target_wallet_id: @target_wallet_id, amount: @amount)
  end

  def withdraw
    DebitTransaction.create(source_wallet_id: @source_wallet_id, amount: @amount)
  end

  def transfer
    CreditTransaction.create(source_wallet_id: @source_wallet_id, target_wallet_id: @target_wallet_id, amount: @amount)
    DebitTransaction.create(source_wallet_id: @source_wallet_id, target_wallet_id: @target_wallet_id, amount: @amount)
  end

  def balance
    Wallet.find(@target_wallet_id).balance
  end

  def transactions_history
    transactions = Transaction.where(transaction_type: 'Credit', target_wallet_id: @target_wallet_id).or(Transaction.where(transaction_type: 'Debit', source_wallet_id: @source_wallet_id)).order(created_at: :desc)

    hash = {}
    transactions.each do |transaction|
      t = { transaction_type: transaction.transaction_type,
            created_at: transaction.created_at.strftime("%FT%T"),
            amount: transaction.amount,
            source_wallet_id: transaction.source_wallet_id,
            target_wallet_id: transaction.target_wallet_id }

      hash[transaction.id] = t
    end

    hash
  end
end