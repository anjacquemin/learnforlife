class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  before_action :character_items_setup, only: [:market, :arene, :profile]

  def home
    @user = current_user
  end

  def market
  end

  def faq
  end

  def arene
  end

  def profile
    @user_profile = User.find(params[:user_id])
  end

  private

  def character_items_setup
    @character_items = CharacterItem.all
    @user = current_user
    @unlocked_hairs = @user.character_items.where(character_items: {item_type: "hair"}).where(user_character_items: {unlocked: true})
    @unlocked_heads = @user.character_items.where(character_items: {item_type: "head"}).where(user_character_items: {unlocked: true})
    @unlocked_bodies = @user.character_items.where(character_items: {item_type: "body"}).where(user_character_items: {unlocked: true})

    @locked_hairs = @user.character_items.where(character_items: {item_type: "hair"}).where(user_character_items: {unlocked: false})
    @locked_heads = @user.character_items.where(character_items: {item_type: "head"}).where(user_character_items: {unlocked: false})
    @locked_bodies = @user.character_items.where(character_items: {item_type: "body"}).where(user_character_items: {unlocked: false})
    @all_types = ["hair", "body", "head", "weapon"]
  end
end
