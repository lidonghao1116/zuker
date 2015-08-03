# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#user-form-edit #user_phone_number').change ->
    if $('div.user_phone_number p.help-block').html().length < 21
      $('div.user_phone_number p.help-block').append("<br><strong>You need to verify if you change your phone number.</strong>");

  $('#connect-fb').click ->
    $('#login_form').removeClass('hide');
