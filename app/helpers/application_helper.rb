module ApplicationHelper
  def body_class
    "#{controller_name} #{action_name}"
	end

  def current_page(path)
    "active" if current_page?(path)
  end

  def small_avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://gravatar.com/avatar/#{gravatar_id}.png?s=20"
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://gravatar.com/avatar/#{gravatar_id}.png?s=35"
  end

  def medium_avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://gravatar.com/avatar/#{gravatar_id}.png?s=90"
  end

  def big_avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://gravatar.com/avatar/#{gravatar_id}.png?s=200"
  end
end
