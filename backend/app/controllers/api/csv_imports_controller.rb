require "csv"

class Api::CsvImportsController < ApplicationController
  def create
    file = params[:file]
    return render json: { error: 'No file uploaded' }, status: :unprocessable_entity unless file

    CSV.foreach(file.path, headers: true) do |row|
      Transaction.create!(
        transaction_date: row['Transaction Date'],
        account_number: row['Account Number'],
        account_holder: row['Account Holder Name'],
        amount: row['Amount'],
        status: row['Status']
      )
    end

    render json: { message: 'CSV imported successfully' }, status: :ok
  end
end
