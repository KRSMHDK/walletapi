class Entity < ApplicationRecord
  has_one :wallet
  after_create :create_wallet

  private

  def create_wallet
    wallet = Wallet.create(entity: self)
    update(wallet_id: wallet.id)
  end
end