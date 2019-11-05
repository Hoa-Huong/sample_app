module UsersHelper
  def gravatar_for user, size: Settings.size_gravatar
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def find_followed_id id
    @relationship = current_user.active_relationships.find_by followed_id: id
    return @relationship if @relationship

    flash[:danger] = t "not_found_relationship"
    redirect_to root_url
  end

  def build_active_relationships
    current_user.active_relationships.build
  end
end
