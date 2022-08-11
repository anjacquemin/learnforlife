class ThemesController < ApplicationController
  def index
    @themes = Theme.all
    @user = current_user
  end

  def show
    @theme = Theme.find(params[:id])
    @user = current_user
    @subtheme_blur = 0
    @level_blur = 0
  end
end
