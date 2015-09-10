$ ->
  $('.reply_btn form.comment').toggle()
  $('.reply_btn').click ->
    $(this).find('form.comment').toggle()
    $(this).find('.reply_text').toggle()