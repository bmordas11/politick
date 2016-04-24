window.onload = init();

function init() {
  $('.upvoter').bind('click', upVote);
  $('.downvoter').bind('click', downVote);
}

function upVote() {
  var id = event.currentTarget.parentElement.children.comment_id.value;
  var request = $.ajax({
    method: "GET",
    url: "/v1/upvote",
    data: { comment_id: id }
  });

  request.done(function(data) {
    element = $('.voter').find(':input[value=' + id + ']')
    element.parent().children()[1].textContent = data.upvotes;
    element.parent().children()[2].textContent = data.downvotes;
  });
}

function downVote() {
  var id = event.currentTarget.parentElement.children.comment_id.value;
  var request = $.ajax({
    method: "GET",
    url: "/v1/downvote",
    data: { comment_id: id }
  });

  request.done(function(data) {
    element = $('.voter').find(':input[value=' + id + ']')
    element.parent().children()[1].textContent = data.upvotes;
    element.parent().children()[2].textContent = data.downvotes;
  });
}
