describe HookExecutionsController do
  describe "POST #create" do
    context "with a valid HttpPostHook" do
      let!(:http_post_hook) { FactoryGirl.create(:http_post_hook, post_urls: ["http://heroku.com/hook/123"]) }

      let!(:stubbed_request) do
        stub_request(:post, "http://heroku.com/hook/123").
          with(body: {"something_else" => "okay"}).
          to_return(status: 200)
      end

      it "returns OK" do
        post :create, {token: http_post_hook.token, something_else: "okay"}
        expect(response.status).to eq(201)
      end

      it "sends the relevant params only" do
        post :create, {token: http_post_hook.token, something_else: "okay"}
        expect(stubbed_request).to have_been_made.once
      end
    end

    context "with an invalid token" do
      it "returns 404" do
        post :create, {token: "invalid", something_else: "okay"}
        expect(response.status).to eq(404)
      end
    end
  end
end
