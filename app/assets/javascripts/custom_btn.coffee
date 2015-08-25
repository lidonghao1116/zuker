$ ->
  radio_class = 'btn-warning'
  checkbox_class = 'btn-info'

  $('label.btn.act_as_radio_button').click (e)->
    e.preventDefault()
    parent_div = $(this).closest("div")
    parent_div.find("label.btn.act_as_radio_button").removeClass(radio_class)
    $(this).addClass(radio_class)
    radio_input = $(this).find('input[type="radio"]')
    radio_input.prop('checked', true)

  $('label.btn.act_as_check_box').click (e)->
    e.preventDefault()
    radio_input = $(this).find('input[type="checkbox"]')
    radio_input.prop('checked', true)
    $(this).toggleClass(checkbox_class)