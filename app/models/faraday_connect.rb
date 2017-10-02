class FaradayConnect

  attr_accessor :url, :index_path, :data

  def initialize(url, index_path, data = {})
    @url =             url
    @index_path =      index_path
    @data =            data
  end

  def connection
    Faraday.new(url: url) do |c|
      c.use Faraday::Response::RaiseError
      c.use Faraday::Request::UrlEncoded
      c.use Faraday::Adapter::NetHttp
      c.headers['Content-Type'] = 'application/json'
    end
  end

  def send_get_request
    response = connection.get(index_path, data)
    Hashie::Mash.new(JSON.parse(response.body))
  end

  def send_post_request
    response = connection.post(index_path) { |r| r.body = data.to_json }
    Hashie::Mash.new(JSON.parse(response.body))
  end
end