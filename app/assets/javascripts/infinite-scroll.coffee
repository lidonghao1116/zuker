$ ->
  console.log '678'
  $(window).scroll (e)->
    e.preventDefault()
    if($(window).scrollTop() + $(window).height() > $(document).height() - 100)
      $('#next_page_link').click()
      console.log '123'
      $("#house-profile").on("ajax:send", (xhr) ->
        $(window).unbind('scroll')
      ).on("ajax:error", (e, xhr, status, error) ->
        $(".ajax-text").text $.parseJSON(xhr.responseText).error
        console.log $.parseJSON(xhr.responseText).error
      ).on("ajax:success", (e, data, status, xhr) ->
        $(window).bind('scroll')
      )