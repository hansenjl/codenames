

var words = document.getElementsByTagName("td.cell")

function current_team(){
  return 'red'
}


function guess_word(e){
  space = e
  text = e.innerHTML
  gameId = document.getElementById("game-id").innerHTML
  //values =  {'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')}
  //let posting = $.post(`/games/${gameId}/words/${text}`, values)
  //is it good to post to controller here?

  $.ajax({
    type: 'post',
    url: `/games/${gameId}/words`,
    data: {"team":`${current_team()}`, "text": `${text}` },
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    },
    success: function(data){
      data
      space.style.backgroundColor = data.color

      if (data.color === 'blue') {
        let blueLeft =  parseInt($("span#blue-left").text(), 10)
        $("span#blue-left").text(blueLeft - 1)
      } else if (data.color === 'red'){
        let redLeft = parseInt($("span#red-left").text(), 10)
        $("span#red-left").text(redLeft - 1)
      } else if (data.color === 'black'){
        alert("Oh no! You lose - Game over! ")
      }
    },
  })
}


function attachListeners(){
  $("td").click(function(){
    guess_word(this)
  })
}


$(document).ready(attachListeners)


function createComment(element){


  posting.done(function(data){

    // create a new comment object
    var comment = new Comment(data["id"], data["text"], data["user"]["username"], data["city"]["name"])

    // add new comment
    var createdComment = comment.formatComment() + " <button class='delete-comment' data='" + comment.id + "' onclick='deleteComment(this)'>Delete</button></li>"
    $("#comments").append(createdComment)

    //reset comment form
    $("#submit").prop( "disabled", false )
    $("#comment_text").val("")

  })
}

function Game(data){
  this.id = data.id
}

// Comment.prototype.formatComment = function(){
//     return "<li id='comment-"+ this.id +"'><strong>" + this.username + ": </strong>" + this.text
//   }
