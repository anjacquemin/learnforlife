class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @user = current_user
  end

  def market
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

  def faq
  end

  def arene
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
