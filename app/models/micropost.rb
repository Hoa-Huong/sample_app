class Micropost < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  scope :order_by_create_at, ->{order(created_at: :desc)}

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.max_content}
  validates :image, content_type: {in: Settings.content_type,
                                   message: I18n.t("mess_valid_image")},
    size: {less_than: Settings.size_image.megabytes,
           message: I18n.t("mess_size_out")}

  def display_image
    image.variant(resize_to_limit: Settings.limit_size_image)
  end
end
