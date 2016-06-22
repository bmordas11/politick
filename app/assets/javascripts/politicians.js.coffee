$(document).ready ->
  $("#politicians .page").infinitescroll
    navSelector: "nav.pagination" # selector for paged navigation
    nextSelector: "nav.pagination a[rel=next]" # selector for the NEXT link
    itemSelector: "#politicians tr.politician" # selector for all items
