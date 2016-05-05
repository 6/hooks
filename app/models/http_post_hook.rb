class HttpPostHook < Hook
  store_accessor :config, :post_urls

  validates :post_urls, length: {minimum: 1}
end
