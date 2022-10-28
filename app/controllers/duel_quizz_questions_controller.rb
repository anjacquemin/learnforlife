class DuelQuizzQuestionsController < ApplicationController
  def index
    @duel_quizz = DuelQuizz.find(params[:duel_quizz_id])
    @duel_quizz_questions = policy_scope(@duel_quizz.duel_quizz_questions)
    @duel = @duel_quizz.duel
    @current_duel_quizz_question = find_current_answer(@duel_quizz_questions)

    if (@quizz_end = check_end_duel_quizz(@duel_quizz))
      score_hp_compute(@duel_quizz)
      duel_update(@duel) if both_player_finished_last_quizz? @duel
      DuelChannel.broadcast_to(@duel, type: "end_quizz", url: duel_url(@duel))
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  private

    def duel_update(duel)
      if @duel.player_1_hp <= 0 || @duel.player_2_hp <= 0
        @duel.step = "end"
        @duel.save!
      else
        @duel.step = "category_choice"
        @duel.player_to_play = [@duel.player_1, @duel.player_2].sample
        @duel.save!
        theme_choices = [Theme.find_by(name: "Géographie"), Theme.find_by(name: "Cinéma")]
        @duel.duel_theme_choices.each_with_index do |duel_theme_choice, i|
          duel_theme_choice.theme = theme_choices[i]
          duel_theme_choice.save!
        end
      end
    end

    def  find_current_answer(duel_quizz_questions)
      duel_quizz_questions.find do |duel_quizz_question|
        if duel_quizz_question.duel_answers.any?
          duel_quizz_question unless duel_quizz_question.duel_answers.find_by(user: current_user)
        else
          duel_quizz_question
        end
      end
    end

    def check_end_duel_quizz(duel_quizz)
      duel_quizz.duel_answers.count { |duel_answer| duel_answer.user == current_user } > 1
    end

    def score_hp_compute(duel_quizz)
      duel = duel_quizz.duel
      score = score_compute(duel_quizz)
      current_player = (duel.player_1 == current_user ? "player_1" : "player_2")
      other_player = (duel.player_1 == current_user ? "player_2" : "player_1")
      duel_quizz.update("score_#{current_player}".to_sym => score)
      hp_other_player = @duel.send("#{other_player}_hp") - score
      hp_other_player = (hp_other_player > 0) ? hp_other_player : 0
      duel_quizz.update("score_#{current_player}".to_sym => score)
      @duel.update("#{other_player}_hp".to_sym => hp_other_player)
    end

    def both_player_finished_last_quizz? duel
      duel.duel_quizzs.all? { |duel_quizz| duel_quizz.score_player_1 && duel_quizz.score_player_2}
    end

    def score_compute(duel_quizz)
      player_answers = duel_quizz.duel_answers.select { |duel_answer| duel_answer.user == current_user }
      score = 0
      difficulty_points = {
        Facile: 1,
        Moyen: 3,
        Difficile: 5
      }
      player_answers.each { |player_answer|
        score += difficulty_points[player_answer.difficulty.to_sym] if player_answer.is_good_answer
      }
      score
    end
end
