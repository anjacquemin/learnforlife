class SubthemesController < ApplicationController
    def show
      # to handle modal records clicks
      respond_to do |format|
        format.html {
          @subtheme = Subtheme.find(params[:id])
          authorize(@subtheme)
          @user = current_user
        }
        format.json {
          @subtheme = Subtheme.find(params[:id])
          authorize(@subtheme)
          @quizz_id = params[:quizz_id]
          @quizz = Quizz.find(@quizz_id)
        }
      end

    end
end
