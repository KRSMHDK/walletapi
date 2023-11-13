require 'faraday'

class LatestStockPrice
  BASE_URL = 'https://latest-stock-price.p.rapidapi.com/'

  def initialize(api_key)
    @api_key = api_key
  end

  def price(indices)
    connection = Faraday.new(url: BASE_URL) do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
      faraday.headers['X-RapidAPI-Key'] = @api_key
      faraday.headers['X-RapidAPI-Host'] = 'latest-stock-price.p.rapidapi.com'
    end

    response = connection.get('/price', { Indices: indices })

    response.body
  end

  def prices(indices)
    connection = Faraday.new(url: BASE_URL) do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
      faraday.headers['X-RapidAPI-Key'] = @api_key
      faraday.headers['X-RapidAPI-Host'] = 'latest-stock-price.p.rapidapi.com'
    end

    response = connection.get('/prices', { Indices: indices })

    response.body
  end

  def price_all
    connection = Faraday.new(url: BASE_URL) do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
      faraday.headers['X-RapidAPI-Key'] = @api_key
      faraday.headers['X-RapidAPI-Host'] = 'latest-stock-price.p.rapidapi.com'
    end

    response = connection.get('/any')

    response.body
  end

end
