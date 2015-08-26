$ ->
  radio_class = 'btn-warning'
  checkbox_class = 'btn-info'

  $('label.btn.act_as_radio_button').click (e)->
    e.preventDefault()
    parent_div = $(this).closest("div")
    parent_div.find("label.btn.act_as_radio_button").removeClass(radio_class)
    input = $(this).find('input[type="radio"]')
    $(this).addClass(radio_class)
    input.prop('checked', true)

  $('label.btn.act_as_check_box').click (e)->
    e.preventDefault()
    input = $(this).find('input[type="checkbox"]')
    input.prop('checked', !input.prop('checked'))
    $(this).toggleClass(checkbox_class)  