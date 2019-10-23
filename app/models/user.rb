class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.regex

  before_save{email.downcase!}

  validates :name, presence: true, length: {maximum: Settings.max_name}
  validates :email, presence: true, length: {maximum: Settings.max_email},
  format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :password, presence: true, length: {minimum: Settings.min_pwd}

  has_secure_password
end
