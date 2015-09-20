$ ->
  reply_forms = $('.reply_btn form.comment')
  reply_forms.toggle()
  
  $('.reply_btn .reply_text').click (e)->
    e.preventDefault()
    console.log $(this).next()
    reply_form = $(this).next().find('form')
    reply_form.toggle()
    reply_form.find('textarea').focus()
    $(this).toggle()
