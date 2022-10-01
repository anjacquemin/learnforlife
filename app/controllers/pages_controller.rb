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

  def parameters
  end

  def profile
    @user_profile = User.find(params[:user_id])
  end

  private

  def character_items_setup
    @character_items = CharacterItem.all
    @user = current_user
    @item_status = CharacterItem.set_character_item_lock_or_not(@user)
    # dont pur hair / head : no item to unlocked (to be added)
    @all_types = ["weapon", "shield", "helmet","body"]
  end
end
