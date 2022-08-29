class ThemesController < ApplicationController
  def index
    @themes = policy_scope(Theme)
    @user = current_user
  end

  def show
    @theme = Theme.find(params[:id])
    authorize(@theme)
    @user = current_user
    @subtheme_blur = 0
    @level_blur = 0
  end
end
