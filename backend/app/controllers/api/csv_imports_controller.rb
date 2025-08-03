class Api::CsvImportsController < ActionController::Base
  

  def create
    file = params[:file]
    unless file
      return render json: { error: 'No file uploaded' }, status: :bad_request
    end

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
  rescue => e
    render json: { error: "Import failed: #{e.message}" }, status: :unprocessable_entity
  end
end