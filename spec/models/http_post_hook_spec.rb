describe HttpPostHook do
  describe "validations" do
    context "without any post_urls specified" do
      subject { FactoryGirl.build(:http_post_hook, post_urls: []) }

      it { is_expected.not_to be_valid }
    end
  end

  describe "#set_token" do
    subject(:http_post_hook) { FactoryGirl.build(:http_post_hook) }

    it "sets a token on create" do
      expect(http_post_hook.token).not_to be_present

      http_post_hook.save!
      expect(http_post_hook.token).to be_present
    end
  end
end
