module ApplicationHelper
  def production?
    Rails.env == "production"
  end
  
  def user_is_owner?
    current_user && (current_user == owner)
  end

  def owner?
    current_user && (current_user == owner)
  end

  def owner
    @owner ||= User.where(:username => params[:username]).first
  end

  def link_to_user(user)
    link_to(user.username, stream_path(:username => user.username))
  end
end
