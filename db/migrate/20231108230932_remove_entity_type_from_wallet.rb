class RemoveEntityTypeFromWallet < ActiveRecord::Migration[7.0]
  def change
    remove_column :wallets, :entity_type
  end
end
