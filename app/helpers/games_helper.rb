module GamesHelper

  def join_leave_link
    if @game.users.include?(current_user)
      link_to('Leave Game', leave_game_path(@game), method: 'patch')
    else
      link_to('Join Game', join_game_path(@game), method: 'patch')
    end
  end

  def start_game_link
    if @game.teams[0].size > 1 && @game.teams[1].size > 1
        link_to('Start Game', start_game_path(@game), method: 'patch')
    end
  end

end