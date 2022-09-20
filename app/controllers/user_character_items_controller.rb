class UserCharacterItemsController < ApplicationController
  def update
    puts params
    user_character_item = UserCharacterItem.find(params[:id])
    authorize(user_character_item)
    price = user_character_item.character_item.price

    if (gold_difference = price - current_user.gold ) > 0
      puts "ICI"
      flash[:alert] = "Achat de #{user_character_item.character_item.name} impossible, il te manque : #{gold_difference} pièce d'or"
      redirect_to market_path
    else
      puts "La"
      user_character_item.bought = true
      current_user.gold -= price
      if current_user.save! && user_character_item.save!
        flash[:notice] = "Achat de #{user_character_item.character_item.name} réalisé avec succès"
        redirect_to market_path
      else
        flash[:alert] = "Achat de #{user_character_item.character_item.name} avorté, merci de ré-essayer ultérieurement"
        redirect_to market_path
      end

    end

  end
end
