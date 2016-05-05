FactoryGirl.define do
  factory :http_post_hook do
    post_urls { ["http://www.google.com/test"] }
  end
end
