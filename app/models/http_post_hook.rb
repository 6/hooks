class HttpPostHook < Hook
  store_accessor :config, :post_urls

  # TODO - ensure that it's an Array, and validate URLs by calling URI.parse
  validates :post_urls, length: {minimum: 1}

  def execute!(forwardable_params)
    post_urls.each do |url|
      begin
        uri = URI.parse(url)
        query = Rack::Utils.parse_query(uri.query)
        query = forwardable_params.merge(query)
        RestClient.post(url, query)
      rescue => e
        # TODO: don't fail silently
      end
    end
  end
end
