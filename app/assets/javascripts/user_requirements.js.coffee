jQuery ->
  $('#userReq').disableSelection
  $('#userReq').sortable({ handle: ".dragHandle" })
  $('#updateReqSortButton').click ->
     $.post('user_requirements/updateSort', $('#userReq').sortable('serialize'))


