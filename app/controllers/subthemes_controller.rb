class SubthemesController < ApplicationController
    def show
      @subtheme = Subtheme.find(params[:id])
      authorize(@subtheme)
      @user = current_user
    end
end
