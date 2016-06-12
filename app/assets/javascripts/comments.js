window.onload = init();

function init(){
  putNewComment();
}

function putNewComment() {
  $( '#submit-comment' ).click(function(event) {
    event.preventDefault();
    var request = $.ajax({
      method: 'POST',
      url: "/v1/addComment",
      data: {
        body: $('#comment_body').val(),
        rating: getCheckedBox(),
        politicianId: $('#politician_id').val()
      }
    });

    request.done(function(data) {
      $('.all-comments').append(data);
      $('#comment_body').val('');
      $(this).checked = false;
      $('.arrow-up').bind('click', upVote);
      $('.arrow-down').bind('click', downVote);
    });
  });
}

function getCheckedBox()
{
  var array = $( ':radio' );
  var matches = $.grep(array, function(radio) {
    return(radio.checked === true);
  });
  if (matches.length)
  {
    var value = matches[0].value;
    return value;
  }else{
    return false;
  }
}
