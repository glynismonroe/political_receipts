json.extract! receipt, :id, :description, :created_at, :updated_at
json.url receipt_url(receipt, format: :json)
