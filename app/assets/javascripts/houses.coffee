$(document).ready ->
  $(".main").on("ajax:send", (xhr) ->
    $(".ajax-text").text "Saving..."
  ).on("ajax:error", (e, xhr, status, error) ->
    $(".ajax-text").text $.parseJSON(xhr.responseText).error
    console.log $.parseJSON(xhr.responseText).error
  ).on("ajax:success", (e, data, status, xhr) ->
    $(".ajax-text").text "Complete."
  )

  # initalize "inputs" and "textareas" data-value attr.
  $(".ajax-input textarea").data('value', $(".ajax-input textarea").val())
  $(".ajax-input input").data('value', $(".ajax-input input").val())
  $('#datetimepicker1').data('value', $('#datetimepicker1').val())
  $('#datetimepicker2').data('value', $('#datetimepicker2').val())

  $(".ajax-input input, .ajax-input textarea").blur ->
    if $(this).data('value') isnt $(this).val()
      $(this).data('value', $(this).val())
      $('form.edit_house input[type="submit"]').click()

  $(".ajax-input select").change ->
    if $(this).data('value') isnt $(this).val()
      $(this).data('value', $(this).val())
      $('form.edit_house input[type="submit"]').click()

  $('#twzipcode').twzipcode();
  $("#twzipcode select").change ->    
    $('form.edit_house input[type="submit"]').click()