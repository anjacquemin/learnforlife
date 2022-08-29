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
          @subtheme = Subtheme.find(params[:subtheme_id])
          authorize(@subtheme)
          data = JSON.parse(params["json"])
          p data["quizz_id"]
          @quizz = Quizz.find(data["quizz_id"].to_i)
        }
      end

    end
end
