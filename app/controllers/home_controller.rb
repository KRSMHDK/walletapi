class HomeController < ApplicationController

  def index
    if session[:user].present?
      @balance = balance
      @transactions = transactions
    end
  end

  def transactions
    response = Faraday.get(transactions_api_v1_wallet_url(session[:user]["id"]))
    JSON.parse(response.body)["transactions_history"]
  end

  def balance
    response = Faraday.get(balance_api_v1_wallet_url(session[:user]["id"]))
    JSON.parse(response.body)["balance"]
  end

  def withdraw
    parameters = { amount: params[:amount] }
    Faraday.post(withdraw_api_v1_wallet_url(session[:user]["id"]), parameters)
  end

  def deposit
    parameters = { amount: params[:amount] }
    Faraday.post(deposit_api_v1_wallet_url(session[:user]["id"]), parameters)
  end

  def transfer
    parameters = { target_wallet_id: params[:entity_id], amount: params[:amount]}
    Faraday.post(transfer_api_v1_wallet_url(session[:user]["id"]), parameters)
  end

  def sign_in
    entity = Entity.find(params[:entity_id])
    session[:user] = entity
    redirect_to root_path
  end

  def sign_out
    session[:user].clear
    redirect_to root_path
  end
end
