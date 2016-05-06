describe HttpPostHook do
  describe "validations" do
    context "without any post_urls specified" do
      subject { FactoryGirl.build(:http_post_hook, post_urls: []).tap(&:valid?).errors.messages }

      it { is_expected.to eq(post_urls: ["must specify at least one URL"]) }
    end

    context "with an invalid post_urls format specified" do
      subject { FactoryGirl.build(:http_post_hook, post_urls: ["  "]).tap(&:valid?).errors.messages }

      it { is_expected.to eq(post_urls: ["has invalid URL:   "]) }
    end

    context "with an invalid post_urls scheme specified" do
      subject { FactoryGirl.build(:http_post_hook, post_urls: ["ftp://google.com", "git@github.com"]).tap(&:valid?).errors.messages }

      it { is_expected.to eq(post_urls: ["scheme must be http or https, but got: ftp://google.com", "scheme must be http or https, but got: git@github.com"]) }
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
