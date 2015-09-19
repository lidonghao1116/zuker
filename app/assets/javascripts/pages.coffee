# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.advanced_search_fields').toggle()
  $('.advanced_search_link').click ->
    $('.advanced_search_fields').toggle()

  $('#sign_in_modal').on('ajax:send', (xhr) ->
    $(this).find('form').addClass('loading')
  ).on('ajax:error', (e, xhr, status, error) ->
    $(this).find('form').removeClass('loading')
    $(this).find('.ui.error.message').addClass('show')
    $('.ui.error.message').html 'Invalid phone_number or password.'
  ).on('ajax:success', (e, data, status, xhr) ->
    $(this).modal('hide');
  )