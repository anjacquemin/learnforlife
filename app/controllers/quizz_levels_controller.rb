class QuizzLevelsController < ApplicationController
    def show
      @quizz_level = QuizzLevel.find(params[:id])
      @quizz = @quizz_level.quizz
      if @quizz_level == "Facile"
        @stars_count = 1
      elsif @quizz_level == "Moyen"
        @stars_count = 2
      else @quizz_level == "Difficile"
        @stars_count = 3
      end
    end
end
