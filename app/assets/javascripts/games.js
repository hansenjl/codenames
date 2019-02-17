

var words = document.getElementsByTagName("td.cell")

function current_team(){
  return 'red'
}


function guess_word(e){
  space = e
  text = e.innerHTML
  gameId = document.getElementById("game-id").innerHTML


  $.ajax({
    type: 'post',
    url: `/games/${gameId}/words`,
    data: {"team":`${current_team()}`, "text": `${text}` },
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    },
    success: function(data){
      debugger
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
    },
  })
}


function attachListeners(){

  //only attach if games aren't done
  // only attach if game has been started
  //when the game is started how do we trigger all screens to refresh?
  //a counter on each page that is sending background get requests to find out if the game is started % if so refresh the screen??
  $("td.cell-unrevealed").click(function(){
    guess_word(this)
  })
}


$(document).ready(attachListeners)


