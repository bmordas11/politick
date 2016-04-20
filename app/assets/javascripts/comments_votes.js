window.onload = init();
var id;

function init(){
  document.getElementById("upvote").addEventListener("click", upVote);
  document.getElementById("downvote").addEventListener("click", downVote);
  id = $("#comment_id").val();
}

function upVote() {
  var request = $.ajax({
    method: "GET",
    url: "/v1/upvote",
    data: { comment_id: id }
  });

  request.done(function(data) {
    document.getElementById("upvote").textContent = data.upvotes;
    document.getElementById("downvote").textContent = data.downvotes;
  });
}

function downVote() {
  var request = $.ajax({
    method: "GET",
    url: "/v1/downvote",
    data: { comment_id: id }
  });

  request.done(function(data) {
    document.getElementById("upvote").textContent = data.upvotes;
    document.getElementById("downvote").textContent = data.downvotes;
  });
}
