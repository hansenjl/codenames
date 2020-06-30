const webSocketUrl = 'ws://localhost:3000/cable'

function current_team(){
  return 'red'
}


function guess_word(e){
  let text = e.innerHTML
  let gameId = document.getElementById("game-id").innerHTML

  $.ajax({
    type: 'post',
    url: `/games/${gameId}/words`,
    data: {"team":`${current_team()}`, "text": `${text}` },
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    },
    success: function(data){
      // updateBoardAfterGuess(data)
    },
  })
}

function updateBoardAfterGuess(data){

  let id = data.card.word_id;
  let space = document.getElementById(`word-${id}`)

  space.style.backgroundColor = data.color
  space.classList.remove("cell-unrevealed")
  space.classList.add("cell-revealed")


  //needs to deactivate click ability of that chosen card


  if (data.color === 'blue') {
    let blueLeft =  parseInt($("span#blue-left").text(), 10)
    $("span#blue-left").text(blueLeft - 1)
  } else if (data.color === 'red'){
    let redLeft = parseInt($("span#red-left").text(), 10)
    $("span#red-left").text(redLeft - 1)
  } else if (data.color === 'black'){
    alert("Oh no! You lose - Game over! ")
    //needs to deactivate event listeners for all cards
  }
}

function createGameWebSocketConn(gameId){
  socket = new WebSocket(webSocketUrl)

  socket.onopen = function(event) {
    console.log('WebSocket Connected')

    const msg = {
      command: 'subscribe',
      identifier: JSON.stringify({
        game_id: gameId,
        channel: 'GameChannel'
        // game: `game_${gameId}`
      })
    }

    // sending the subscribe command
    socket.send(JSON.stringify(msg))
  }

  socket.onclose = function(event){
    console.log('websocket closed')
  }

  socket.onmessage = function(event) {
    const response = event.data
    const msg = JSON.parse(response)
    // Ignores pings
    if(msg.type == 'ping'){
      return
    }


    console.log("FROM RAILS: ", msg);

    if (msg.message){
      updateBoardAfterGuess(msg.message)
    }





  }

  // When an error occurs through the websocket connection, this code is run printing the error message.
  socket.onerror = function(error) {
    console.log('WebSocket Error: ' + error);
  }
}


function attachListeners(){
  console.log('on games page')
  gameId = document.getElementById("game-id").innerHTML
  createGameWebSocketConn(gameId)

  //only attach if games aren't done
  // only attach if game has been started
  $("td.cell-unrevealed").click(function(){
    guess_word(this)
  })
}

$(document).ready(function() {
  $(".games.show").ready(() => attachListeners())
});



