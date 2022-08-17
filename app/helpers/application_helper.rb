module ApplicationHelper
  def is_unlocked_for_user?(item, key, user)
    all_user_items_progress = user.send("#{key}_progresses")
    all_user_items_progress.find_by({key.to_sym => item})&.unlocked
  end
end
