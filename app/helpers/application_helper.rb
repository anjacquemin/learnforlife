module ApplicationHelper
  include RecordsHelper
  def is_unlocked_for_user?(item, key, user)
    all_user_items_progress = user.send("#{key}_progresses")
    all_user_items_progress.find_by({key.to_sym => item})&.unlocked
  end

  def seconds_to_minutes(seconds)
    minutes = seconds / 60
    if minutes != 0
      seconds = seconds % (minutes * 60)
      "#{minutes}:#{seconds}"
    else
      seconds
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
