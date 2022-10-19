class DuelsController < ApplicationController

  before_action :character_items_setup, only: [:index]

  def show
    # Several steps
    # 1 : created
    # 2 : category_choice
    # 3 : ongoing quizz
    # 4 : end

    @duel = Duel.find(params[:id])
    authorize @duel

    if @duel.duel_quizzs.empty?
      #if player_session not defined, it means that it is the second player who joins (the session of the first player is created when the duel is)
      unless (session["player-duel-#{@duel.id}".to_sym] || @duel.is_ready)
        session["player-duel-#{@duel.id}".to_sym] = "player2"
        @duel.update_attribute(:is_ready, true)
        @duel.update_attribute(:player_to_play, [@duel.player_1, @duel.player_2].sample)
        DuelChannel.broadcast_to(@duel, type: "ready_to_play", player_to_play: @duel.player_to_play.name)
      end

      player_session = session["player-duel-#{@duel.id}".to_sym]

      @display_duel_class = (@duel.is_ready ? "d" : "d-none")
      @display_waiting_class = (@duel.is_ready ? "d-none" : "d")

      @theme_choices = [Theme.find_by(name: "Géographie"), Theme.find_by(name: "Cinéma")]
      @display_theme_choice_class = set_if_player_or_not(current_user, @duel.player_to_play , "d", "d-none")
    else
      # know if current_user has finished his last quel_quizzs
      if both_player_finished_last_quizz? @duel
        # display new theme choice

      elsif current_player_finished_last_quizz? @duel
        #display all + message / diplay wait other user
      else
        #diplay current quizz button to play
      end


    end
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
      session["player-duel-#{@duel.id}".to_sym] = "player1"
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

  def set_if_player_or_not(player_session, player_expected, arg1, arg2)
    player_session == player_expected ? arg1 : arg2
  end

  def both_player_finished_last_quizz? duel
    duel.duel_quizzs.all? { |duel_quizz| duel_quizz.score_player_1 && duel_quizz.score_player_2}
  end

  def current_player_finished_last_quizz? duel
    player_X = (duel.player_1 == current_user ? "player_1" : "player_2")
    duel.duel_quizzs.any? { |duel_quizz| duel_quizz.send("score_#{player_X}")}
  end

end
