$ ->
  $('label.btn.act_as_radio_button').click ->
    $('label.btn.act_as_radio_button').removeClass('btn-info')
    $(this).addClass('btn-info')
  $('label.btn.act_as_check_box').click ->
    $(this).toggleClass('btn-info')