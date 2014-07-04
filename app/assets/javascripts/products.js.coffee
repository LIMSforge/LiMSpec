# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#industry_id').change ->
    industry_id = $('#industry_id').val()
    prodID = $('input#prod_id').val()
    $.ajax
      url: '/products/FilteredQuestionList'
      type: 'GET'
      data:
        industry_id: industry_id
        prodID: prodID
      dataType: 'html'
      success: (returndata, textStatus, jqXHR) ->
        $('#question_list').html(returndata)
