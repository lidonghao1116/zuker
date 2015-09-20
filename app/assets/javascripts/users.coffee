# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#user_last_name').focus()
  edit_phone_input = $('#user-form-edit #user_phone_number')
  edit_phone_input.focus()
  help_block = $('div.user_phone_number p.help-block')
  original_help_text = help_block.html()
  warning_text = "<strong style='color: red;'>You will get a SMS message later.</strong>"
  edit_phone_input.change ->
    if $(this).val() isnt $(this).attr('value')
      help_block.html(warning_text)
    else
      help_block.html(original_help_text)

  $('#connect-fb').click ->
    $('#login_form').removeClass('hide');