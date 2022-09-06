class CharactersController < ApplicationController
  def update
    user = current_user
    data = JSON.parse(params["json"])
    puts ("received data in method crete/records : #{data}")
    body = data["body"]
    hair = data["hair"]
    head = data["head"]

    @character = Character.find(params[:id])
    authorize @character

    @character.body = body
    @character.hair = hair
    @character.head = head

    @character.save!

    @user = current_user

    respond_to do |format|
      format.json
    end
  end
end
