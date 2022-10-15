class DuelsController < ApplicationController
  def index
    #display ongoing waited duels
    #display create of a new duel
    @duels = Duel.all
  end


end
