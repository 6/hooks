class Hook < ActiveRecord::Base
  before_validation :set_token, on: :create

  validates :token, presence: true, uniqueness: true
  validates :config, presence: true

private

  def set_token
    self.token ||= SecureRandom.urlsafe_base64(30)
  end
end
