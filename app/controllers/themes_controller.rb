class ThemesController < ApplicationController
  def index
    @themes = Theme.all
    @user = current_user
  end

  def show
    @theme = Theme.find(params[:id])
  end
end
