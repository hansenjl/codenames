class GameChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    @game = Game.find(params[:game_id])
    stream_for @game
    # stream_from "game_#{params[:game_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
