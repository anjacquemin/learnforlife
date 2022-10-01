class CharactersController < ApplicationController
  def update
    user = current_user
    data = JSON.parse(params["json"])
    puts ("received data in method crete/records : #{data}")
    body = data["body"]
    hair = data["hair"]
    head = data["head"]
    helmet = data["helmet"]
    weapon = data["weapon"]
    shield = data["shield"]

    @character = Character.find(params[:id])
    authorize @character

    @character.body = body
    @character.hair = hair
    @character.head = head
    @character.helmet = helmet
    @character.weapon = weapon
    @character.shield = shield

    @character.save!

    @user = current_user

    respond_to do |format|
      format.json
    end
  end
end
