module Api
  module V1
    class WalletsController < ApplicationController
      before_action :authenticate_user

      def deposit
        user = User.find(1)
        amount = params[:amount].to_i

        if amount <= 0
          render json: { error: 'Invalid deposit amount' }, status: :bad_request
        else
          user.wallet.deposit(amount)
          render json: { message: 'Deposit successful' }, status: :ok
        end
      end

      def withdraw
        user = User.find(1)
        amount = params[:amount].to_i

        if amount <= 0
          render json: { error: 'Invalid Withdraw amount' }, status: :bad_request
        else
          user.wallet.withdraw(amount)
          render json: { message: 'Withdraw successful' }, status: :ok
        end
      end

      def balance
        @user = User.find(1)
        balance = @user.wallet.balance

        response = { balance: balance }
        render json: response, status: :ok
      end

      def transactions
        data = { message: 'Data retrieved successfully' }
        render json: data, status: :ok
      end

      private

      def authenticate_user
    
      end
    end
  end
end