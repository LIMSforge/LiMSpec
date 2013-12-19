jQuery ->
  $('#qTable').disableSelection
  $('#qTable').sortable({ handle: ".dragHandle" })
  $('#updateQSortButton').click ->
     $.post('user_questions/updateSort', $('#qTable').sortable('serialize'))



