class Api::V1::TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all

    render json: { message: "Success", data: @transactions, count: @transactions.count }
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      render json: @transaction, status: :created, location: api_v1_transactions_url(@transaction)
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:account_number, :account_holder, :amount, :status)
  end
end
