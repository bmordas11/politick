$(document).ready ->
  $("#politicians .page").infinitescroll
    loading:
      finishedMsg: "<em>Congratulations, you've reached the end of the internet.</em>"
      msgText: "<em>Loading the next set of politicians...</em>"
      speed: 'fast'
    navSelector: "nav.pagination" # selector for paged navigation
    nextSelector: "nav.pagination a[rel=next]" # selector for the NEXT link
    itemSelector: "#politicians tr.politician" # selector for all items
