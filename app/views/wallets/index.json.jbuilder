json.array!(@wallets) do |wallet|
  json.extract! wallet, :id, :key, :secret
  json.url wallet_url(wallet, format: :json)
end
