$ ->
  console.log '678'
  $(window).scroll (e)->
    e.preventDefault()
    if($(window).scrollTop() + $(window).height() > $(document).height() - 100)
      $('#next_page_link').click()