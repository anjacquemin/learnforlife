class ThemesController < ApplicationController
  def index
    @themes = policy_scope(Theme)
    @user = current_user

    @item_status = CharacterItem::set_character_item_lock_or_not(@user)

    @themes_stats = {}
    @unlocked_categories_achievements = {}
    @total_unlocked_items = 0
    @themes.each do |theme|
      total_crowns = Record.where(user: current_user, crown_or_sphere: "crown").joins(:theme).where(themes: {name: theme.name}).group(:quizz_level_id).maximum(:completion).sum{|k,v|v}
      total_spheres = Record.where(user: current_user, crown_or_sphere: "sphere").joins(:theme).where(themes: {name: theme.name}).group(:quizz_level_id).maximum(:completion).sum{|k,v| v }
      total = total_crowns + total_spheres
      @themes_stats[theme.name.to_sym] = {
        total: total,
        spheres: total_spheres,
        crowns: total_crowns
      }
      theme_achievements = unlocked_theme_achievements_calculation(theme, @themes_stats[theme.name.to_sym])
      # @total_unlocked_items += theme_achievements.size
      # @unlocked_categories_achievements[theme.name.to_sym] = theme_achievements unless theme_achievements.size.zero?
    end

    # global_achievements = unlocked_global_achievements_calculation(@themes_stats)
    # @unlocked_categories_achievements[:global] = global_achievements unless global_achievements.size.zero?
    # @total_unlocked_items += global_achievements.size

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @theme = Theme.find(params[:id])
    authorize(@theme)
    @user = current_user
    @subtheme_blur = 0
    @level_blur = 0
  end

  def unlocked_theme_achievements_calculation(theme, theme_stats)
    locked_achievements = current_user.achievements.joins(:user_achievements).where(user_achievements: {unlocked: false}).where(achievement_category: theme.name)

    achievements_to_unlocked = []

    total_theme_crowns = theme.quizz_levels.joins(:quizz).where(quizz: {crown_or_sphere: "crown"}).count * 3
    crown_completion = (theme_stats[:crowns] / (total_theme_crowns.nonzero? || 1))

    total_theme_spheres = theme.quizz_levels.joins(:quizz).where(quizz: {crown_or_sphere: "sphere"}).count * 3
    sphere_completion = (theme_stats[:crowns] / (total_theme_crowns.nonzero? || 1))

    locked_achievements.each do |achievement|
      achievement_type = achievement.achievement_type
      if achievement_type == "crown_percentage"
        if crown_completion > (achievement.count.to_i / 100)
          achievements_to_unlocked << unlock_achievement(achievement)
        end
      elsif achievement_type ==  "sphere_percentage"
        if sphere_completion > (achievement.count.to_i / 100)
          achievements_to_unlocked << unlock_achievement(achievement)
        end
      elsif achievement_type ==  "crown_count"
        if theme_stats[:crowns] > achievement.count.to_i
          achievements_to_unlocked << unlock_achievement(achievement)
        end
      elsif achievement_type ==  "sphere_count"
        if theme_stats[:spheres] > achievement.count.to_i
          achievements_to_unlocked << unlock_achievement(achievement)
        end
      end
    end
    achievements_to_unlocked = []
  end
end

def unlocked_global_achievements_calculation(themes_stats)
  total_crowns = themes_stats.values.map {|value| value[:crowns]}.reduce(&:+)
  total_spheres = themes_stats.values.map {|value| value[:spheres]}.reduce(&:+)
  locked_achievements = current_user.achievements.joins(:user_achievements).where(user_achievements: {unlocked: false}).where(achievement_category: "global")

  achievements_to_unlocked = []

  locked_achievements.each do |achievement|
    achievement_type = achievement.achievement_type
    if achievement_type == "crown_count"
      if total_crowns > achievement.count.to_i
        achievements_to_unlocked << unlock_achievement(achievement)
      end
    elsif achievement_type == "sphere_count"
      if total_spheres > achievement.count.to_i
        achievements_to_unlocked << unlock_achievement(achievement)
      end
    end
  end
  achievements_to_unlocked
end

def unlock_achievement(achievement)
  achievement_to_unlock = current_user.user_achievements.find_by(achievement: achievement)
  achievement_to_unlock.unlocked = true
  achievement_to_unlock.save!
  achievement
end
