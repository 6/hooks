class HttpPostHook < Hook
  store_accessor :config, :post_urls

  validate :validate_post_urls

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

private

  def validate_post_urls
    if !post_urls.is_a?(Array) || post_urls.empty?
      errors.add(:post_urls, "must specify at least one URL")
      return
    end

    post_urls.each do |url|
      begin
        uri = URI.parse(url)
        if !%w[http https].include?(uri.scheme)
          errors.add(:post_urls, "scheme must be http or https, but got: #{url}")
        end
      rescue
        errors.add(:post_urls, "has invalid URL: #{url}")
      end
    end
  end
end
