class HomeController < ApplicationController

  def index
    @user = User.find(1)
    # @balance = fetch_balance["balance"]
  end

  private
  def fetch_balance
    response = Faraday.get(balance_api_v1_wallets_url)
    JSON.parse(response.body)
  end
end
