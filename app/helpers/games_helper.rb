module GamesHelper

  def join_leave_link
    if @game.users.include?(current_user)
      link_to('Leave Game', leave_game_path(@game), method: 'post')
    else
      link_to('Join Game', join_game_path(@game), method: 'post')
    end
  end

end