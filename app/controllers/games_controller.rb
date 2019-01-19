class GamesController < ApplicationController
   before_action :set_game, only: [:show, :edit, :update, :destroy]
   before_action :redirect_if_not_owner, only: [:edit, :update, :destroy]

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
      @game.generate_board
      redirect_to game_path(@game)
    else
      render 'new'
    end
  end


  def update
    @game.update(game_params)
    if @game.save
      redirect_to game_path(@game)
    else
      render 'edit'
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:num_of_players, :name)
  end

  def redirect_if_not_owner
    if @game.creator != current_user
      flash[:alert] = "You don't have permission to do that action"
      redirect_to games_path
    end
  end
end