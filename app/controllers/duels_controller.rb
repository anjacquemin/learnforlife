class DuelsController < ApplicationController

  before_action :character_items_setup, only: [:index]

  def show
    @duel = Duel.find(params[:id])
    authorize @duel

    #if player_session not defined, it means that it is the second player who joins (the session of the first player is created when the duel is)
    unless (player_session = session["player-#{@duel.id}".to_sym] && !@duel.is_ready)
      player_session = "player2"
      @duel.update_attribute(:is_ready, true)
      @duel.update_attribute(:player_to_play, [@duel.player_1, @duel.player_2].sample)
      DuelChannel.broadcast_to(@duel, type: "ready_to_play")
    end
    #initialize all variable needed for the view for stimulus JS
    @theme_choices = [Theme.find_by(name: "Géographie"), Theme.find_by(name: "Cinéma")]
    @display_duel_class = set_if_player2_or_not(player_session, "d", "d-none")
    @display_waiting_class = set_if_player2_or_not(player_session, "d-none", "d")
    @display_theme_choice_class = set_if_player2_or_not(player_session, "d-none", "d")
  end

  def index
    #display ongoing waited duels
    #display create of a new duel
    @duels = policy_scope(Duel)
  end

  def create
    player_1 = User.find(params[:player_1])
    player_2 = User.find(params[:player_2])
    @duel = Duel.new(
      player_1: player_1,
      player_2: player_2,
      player_1_hp: player_1.hp,
      player_2_hp: player_2.hp,
      player_to_play: [player_1, player_2].sample
      )

    authorize @duel

    # @duel.number_of_players = 1
    if @duel.save!
      session["player-#{@duel.id}".to_sym] = "player1"
      redirect_to(@duel)
    else
      @duel.valid?
      flash[:info] = @duel.errors.messages.map{|k, v| "#{k} #{v.first} \n" }.join(" & ")
      redirect_to duels_path
    end
  end

  private

  def character_items_setup
    @character_items = CharacterItem.all
    @user = current_user
    @item_status = CharacterItem.set_character_item_lock_or_not(@user)
    # dont pur hair / head : no item to unlocked (to be added)
    @all_types = ["weapon", "shield", "helmet","body"]
  end

  def set_if_player2_or_not(player_session, arg1, arg2)
    player_session == "player2" ? arg1 : arg2
  end

end
