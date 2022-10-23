class DuelChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
      puts "subscribed channel"
      puts "params : "
      puts params
      duel = Duel.find(params[:id])
      stream_for duel
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
