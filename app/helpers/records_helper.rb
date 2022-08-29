module RecordsHelper
  def findBestQuizzRecords(quizz)
    quizz_levels_records = BestRecord.all.joins(:quizz_level,record: :user).where(quizz_level: {quizz:quizz}).group("users.name").pluck('users.name, SUM(records.completion), SUM(records.seconds_duration), SUM(records.milliseconds_duration)')

    quizz_levels_records.map! do |record|
      {name: record[0], completion: record[1], seconds_duration: record[2], milliseconds_duration: record[3]}
    end

    all_best_quizz_records = quizz_levels_records.sort_by{|record| [-record[:completion], record[:seconds_duration], record[:milliseconds_duration]]}
  end

  def findBestThemeRecords(theme)
    BestRecord.all.joins(:theme,record: :user).where(theme: {name:Theme.first.name}).group("users.name").pluck('users.name, SUM(records.completion), SUM(records.seconds_duration), SUM(records.milliseconds_duration)')
  end

  def findBestAllThemesRecords
    all_theme_records = BestRecord.all.joins(:theme,record: :user).group("users.name").pluck('users.name, SUM(records.completion), SUM(records.seconds_duration), SUM(records.milliseconds_duration)')

    all_theme_records.map! do |record|
      {name: record[0], completion: record[1], seconds_duration: record[2], milliseconds_duration: record[3]}
    end

    all_best_theme_records = all_theme_records.sort_by{|record| [-record[:completion], record[:seconds_duration], record[:milliseconds_duration]]}
  end

  def user_ranking(all_best_quizz_records)
    return 0 if all_best_quizz_records.size < 1

    user_index = all_best_quizz_records.index{ |best_record| best_record[:name] == current_user.name}
    user_index ? user_index + 1 : 0
  end

  def quizz_total_crowns_and_spheres(quizz)
    user_total_crowns =  quizz.records.where(user: current_user, crown_or_sphere: "crown").group(:quizz_level_id).maximum(:completion).sum{|k,v|v}
    user_total_spheres =  quizz.records.where(user: current_user, crown_or_sphere: "sphere").group(:quizz_level_id).maximum(:completion).sum{|k,v|v}
    user_total_crowns + user_total_spheres
  end

  def completion
  end

end
