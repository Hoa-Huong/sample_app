module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "ror_sample_app"
    if page_title.blank?
      base_title
    else
      page_title
    end
  end
end
