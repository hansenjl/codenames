

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
  $("td.cell-unrevealed").click(function(){
    guess_word(this)
  })
}


$(document).ready(attachListeners)


// function createComment(element){


//   posting.done(function(data){

//     // create a new comment object
//     var comment = new Comment(data["id"], data["text"], data["user"]["username"], data["city"]["name"])

//     // add new comment
//     var createdComment = comment.formatComment() + " <button class='delete-comment' data='" + comment.id + "' onclick='deleteComment(this)'>Delete</button></li>"
//     $("#comments").append(createdComment)

//     //reset comment form
//     $("#submit").prop( "disabled", false )
//     $("#comment_text").val("")

//   })
// }

// function Game(data){
//   this.id = data.id
// }

// Comment.prototype.formatComment = function(){
//     return "<li id='comment-"+ this.id +"'><strong>" + this.username + ": </strong>" + this.text
//   }
