$ ->
  $('.ui.rating').rating()
  $('i.warning.icon.big').popup()
  $('.ui.dropdown').dropdown()
  $('#sign_in_modal').modal()
  $('.sign_in_link').click ->
    $('#sign_in_modal').modal('show')