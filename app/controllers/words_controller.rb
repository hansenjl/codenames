class WordsController < ApplicationController
  before_action :set_game, only: [:guess]
  before_action :set_team, only: [:guess]

  def guess
    result = @team.check_guess(params[:text])
    result[:card].update(revealed: true)
    result[:game] = @game

    # {"team"=>"red", "text"=>"mat", "controller"=>"words", "action"=>"guess", "game_id"=>"15"} permitted: false>

    # need to change space to revealed
    #need to determine if turn ends

    # render json: result, status: 201
    # send websocket message instead
    #  GameChannel.broadcast_to("game_#{params[:game_id]}", result)
    GameChannel.broadcast_to(@game, result)
  end

  private

   def set_team
      @team = @game.teams.find_by(color: params[:team])
   end

   def set_game
      @game = Game.find_by(id: params[:game_id])
   end

 end