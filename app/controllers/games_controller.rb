class GamesController < ApplicationController
   before_action :set_game, only: [:show]

  def index
    @games = Game.all
  end

  def show
  end

  def new
    @game = Game.new
  end

  def create
    @game = current_user.created_games.build(game_params)
    if @game.save
      redirect_to game_path(@game)
    else
      render 'new'
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:num_of_players, :name)
  end
end