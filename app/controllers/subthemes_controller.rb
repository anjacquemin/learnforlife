class SubthemesController < ApplicationController
    def show
      @subtheme = Subtheme.find(params[:id])
      @user = current_user
    end
end
