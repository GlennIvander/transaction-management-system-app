require "csv"

class Api::V1::TransactionsController < ApplicationController
  def index
    @transactions = Transaction.order(created_at: :desc)

    render json: @transactions
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      render json: @transaction, status: :created, location: api_v1_transactions_url(@transaction)
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def import
    if params[:file].blank?
      redirect_to transactions_path, alert: "No file selected."
      return
    end

    Topic.import(params[:file])
    redirect_to transactions_path, notice: "Topics Data imported"
  end

  private

  def transaction_params
    params.require(:transaction).permit(:account_number, :account_holder, :amount, :status)
  end
end
