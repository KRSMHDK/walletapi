class HomeController < ApplicationController

  before_action :set_entity

  def index
    if session[:user].present?
      @balance = balance
      @transactions = transactions
    end
  end

  def api_docs;end

  def transactions
    parameters = { entity_id: @entity.id }
    response = Faraday.get(transactions_api_v1_wallets_url, parameters)
    JSON.parse(response.body)["transactions_history"]
  end

  def balance
    parameters = { entity_id: @entity.id }
    response = Faraday.get(balance_api_v1_wallets_url, parameters)
    JSON.parse(response.body)["balance"]
  end

  def withdraw
    parameters = { amount: params[:amount], entity_id: @entity.id }
    Faraday.post(withdraw_api_v1_wallets_url, parameters)

    redirect_to root_path
  end

  def deposit
    parameters = { amount: params[:amount], entity_id: @entity.id }
    Faraday.post(deposit_api_v1_wallets_url, parameters)
    
    redirect_to root_path
  end

  def transfer
    parameters = { entity_id: @entity.id, target_wallet_id: params[:entity_id], amount: params[:amount]}
    Faraday.post(transfer_api_v1_wallets_url, parameters)

    redirect_to root_path
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

  private
  def set_entity
    if session[:user].present?
      @entity = Entity.find(session[:user]["id"])
    end
  end
end
