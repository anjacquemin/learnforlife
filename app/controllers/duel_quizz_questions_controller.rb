class DuelQuizzQuestionsController < ApplicationController
  def index
    @duel_quizz = DuelQuizz.find(params[:duel_quizz_id])
    @duel_quizz_questions = policy_scope(@duel_quizz.duel_quizz_questions)
    @duel = @duel_quizz.duel
    # Return the first quizz question with not answered by current_user
    @current_duel_quizz_question = @duel_quizz_questions.find do |duel_quizz_question|
      if duel_quizz_question.duel_answers.any?
        duel_quizz_question unless duel_quizz_question.duel_answers.find_by(user: current_user)
      else
        duel_quizz_question
      end
    end

    if (@quizz_end = check_end_duel_quizz(@duel_quizz))
      score_compute(@duel_quizz)
      if both_player_finished_last_quizz? @duel
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
      DuelChannel.broadcast_to(@duel, type: "end_quizz", url: duel_url(@duel))
    end


    respond_to do |format|
      format.html
      format.json
    end
  end
end


def check_end_duel_quizz(duel_quizz)
  p duel_quizz.duel_answers.count { |duel_answer| duel_answer.user == current_user }
  duel_quizz.duel_answers.count { |duel_answer| duel_answer.user == current_user } > 1
end

def score_compute(duel_quizz)
  duel_quizz.duel_answers.where(user: current_user)
  score = 5
  if duel_quizz.duel.player_1 == current_user
    duel_quizz.update(score_player_1: score)
    hp_other_player = @duel.player_2_hp - score
    hp_other_player = (hp_other_player > 0) ? hp_other_player : 0
    @duel.update(player_2_hp: hp_other_player)
  else
    duel_quizz.update(score_player_2: score)
    hp_other_player = @duel.player_1_hp - score
    hp_other_player = (hp_other_player > 0) ? hp_other_player : 0
    @duel.update(player_1_hp: hp_other_player)
  end

  def both_player_finished_last_quizz? duel
    duel.duel_quizzs.all? { |duel_quizz| duel_quizz.score_player_1 && duel_quizz.score_player_2}
  end

end
