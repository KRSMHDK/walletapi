class User < ApplicationRecord
  has_one :wallet, as: :entity, class_name: 'Wallet'
end
