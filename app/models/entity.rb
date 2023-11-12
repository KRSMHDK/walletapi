class Entity < ApplicationRecord
  has_one :wallet
  after_create :create_wallet

  private

  def create_wallet
    Wallet.create(entity: self)
  end
end