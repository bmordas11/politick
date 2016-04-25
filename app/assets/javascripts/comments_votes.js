window.onload = init();

function init() {
  $('.arrow-up').bind('click', upVote);
  $('.arrow-down').bind('click', downVote);
}

function upVote() {
  var id = event.currentTarget.parentElement.children.comment_id.value;
  var request = $.ajax({
    method: "GET",
    url: "/v1/upvote",
    data: { comment_id: id }
  });

  request.done(function(data) {
    var element = $('.upper-' + id);
    element[0].textContent = data.upvotes;
    element.siblings()[0].textContent = data.downvotes;
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
    var element = $('.downer-' + id);
    element.siblings()[0].textContent = data.upvotes;
    element[0].textContent = data.downvotes;
  });
}
