class ChangeWalletBalanceType < ActiveRecord::Migration[7.0]
  def change
    change_column :wallets, :balance, :int
  end
end
