$(document).ready ->
  $(".main").on("ajax:send", (xhr) ->
    $(".ajax-text").text "Saving..."
  ).on("ajax:error", (e, xhr, status, error) ->
    $(".ajax-text").text $.parseJSON(xhr.responseText).error
    console.log $.parseJSON(xhr.responseText).error
  ).on("ajax:success", (e, data, status, xhr) ->
    $(".ajax-text").text "Complete."
  )
  $(".ajax-input textarea").attr('value', $(".ajax-input textarea").val())
  $('#datetimepicker1').attr('value', $('#datetimepicker1').val())
  $('#datetimepicker2').attr('value', $('#datetimepicker2').val())
  $(".ajax-input input[type='text'], .ajax-input textarea").blur ->
    console.log $(this).attr('value')
    console.log $(this).val()
    if $(this).attr('value') isnt $(this).val()
      $(this).attr('value', $(this).val())
      $('form.edit_house input[type="submit"]').click()