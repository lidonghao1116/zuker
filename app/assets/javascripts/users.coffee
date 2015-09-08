# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#user-form-edit #user_phone_number').change ->    
    $('div.user_phone_number p.help-block').html("<strong style='color: red;'>You will get a SMS messege later.</strong>");

  $('#connect-fb').click ->
    $('#login_form').removeClass('hide');
