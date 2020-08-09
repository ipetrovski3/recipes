class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  has_secure_password

  has_many :recipes, dependent: :destroy

  has_one_attached :profile_picture

  before_save :mail_to_downcase

  validates :name, presence: true, length: { maximum: 30 }
  validates :handle_name, presence: true
  validates :mail, presence: true, length: { maximum: 50 },
                   format: { with: VALID_EMAIL_REGEX },
                   uniqueness: true
  validates :password, length: { minimum: 6 }

  private

  def mail_to_downcase
    self.mail = mail.downcase
  end
end
