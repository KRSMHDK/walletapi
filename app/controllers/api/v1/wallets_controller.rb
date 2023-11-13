module Api
  module V1
    class WalletsController < ApplicationController
      before_action :set_user
      skip_before_action :verify_authenticity_token

      def deposit
        amount = params[:amount].to_i

        if amount <= 0
          render json: { error: 'Invalid deposit amount' }, status: :bad_request
        else
          TransactionService.new(amount:, target_wallet_id: @entity.id).deposit
          render json: { message: 'Deposit successful' }, status: :ok
        end
      end

      def withdraw
        amount = params[:amount].to_i

        if amount <= 0
          render json: { error: 'Invalid Withdraw amount' }, status: :bad_request
        else
          TransactionService.new(amount:, source_wallet_id: @entity.id).withdraw
          render json: { message: 'Withdraw successful' }, status: :ok
        end
      end

      def balance
        balance = TransactionService.new(target_wallet_id: @entity.id, source_wallet_id: @entity.id).balance
        render json: { balance: }, status: :ok
      end

      def transfer
        TransactionService.new(target_wallet_id: params[:target_wallet_id], source_wallet_id: @entity.id, amount: params[:amount]).transfer
      end

      def transactions
        transactions_history = TransactionService.new(target_wallet_id: @entity.id, source_wallet_id: @entity.id).transactions_history
        render json: { transactions_history: }, status: :ok
      end

      private

      def set_user
        @entity = Entity.find(params[:entity_id])
      end
    end
  end
end