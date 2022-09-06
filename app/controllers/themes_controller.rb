class ThemesController < ApplicationController
  def index
    @themes = policy_scope(Theme)
    @user = current_user

    @unlocked_hairs = @user.character_items.where(character_items: {item_type: "hair"}).where(user_character_items: {unlocked: true})
    @unlocked_heads = @user.character_items.where(character_items: {item_type: "head"}).where(user_character_items: {unlocked: true})
    @unlocked_bodies = @user.character_items.where(character_items: {item_type: "body"}).where(user_character_items: {unlocked: true})



    respond_to do |format|
      format.html
      format.json
    end


  end

  def show
    @theme = Theme.find(params[:id])
    authorize(@theme)
    @user = current_user
    @subtheme_blur = 0
    @level_blur = 0
  end
end
