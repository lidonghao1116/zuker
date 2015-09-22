$(document).ready ->
  $("#house-profile").on("ajax:send", (xhr) ->
    $(".ajax-text").text "Saving..."
  ).on("ajax:error", (e, xhr, status, error) ->
    $(".ajax-text").text $.parseJSON(xhr.responseText).error
    console.log $.parseJSON(xhr.responseText).error
  ).on("ajax:success", (e, data, status, xhr) ->
    $(".ajax-text").text "Complete."
  )

  # initalize "inputs" and "textareas" data-value attr.
  $(".ajax-input textarea").data('value', $(".ajax-input textarea").val())
  $(".ajax-input input").data('value', $(".ajax-input input").val())
  $('#house_reservable_date').data('value', $('#house_reservable_date').val())
  $('#datetimepicker2').data('value', $('#datetimepicker2').val())

  $(".ajax-input input[type='radio']").parent("label.btn.act_as_radio_button").click ->
    $('form.edit_house').submit()

  $(".ajax-input input[type='checkbox']").parent("label.btn.act_as_check_box").click ->
    $('form.edit_house').submit()

  $(".ajax-input input, .ajax-input textarea").blur ->
    #console.log $(this).data('value')
    #console.log $(this).val()
    if $(this).data('value') isnt $(this).val()
      $(this).data('value', $(this).val())
      $('form.edit_house').submit()

  $(".ajax-input select").change ->
    if $(this).data('value') isnt $(this).val()
      $(this).data('value', $(this).val())
      $('form.edit_house').submit()

  $('#twzipcode').twzipcode();
  $("#twzipcode select").change ->
    $('form.edit_house').submit()



  map = new GMaps (
    div: '#map'
    lat: 23.5
    lng: 121.0
  )
  # alert gon.address
  # for address in gon.addresses
  Object.keys(gon.datas).forEach (key) ->
    GMaps.geocode
      address: key.trim()
      callback: (results, status) ->
        if status is 'OK'
          latlng = results[0].geometry.location
          map.addMarker
            lat: latlng.lat()
            lng: latlng.lng()
            infoWindow: content: gon.datas[key]
          marker = map.markers[map.markers.length - 1]
          marker.visible = false
          (marker.infoWindow).open(map, marker)

          # set template first
          $('#123').parent().parent().parent().addClass('abcdef')

  map.fitZoom()
    

  $('#geocoding_form').submit (e) ->
    e.preventDefault()
    GMaps.geocode
      address: $('#address').val().trim()
      callback: (results, status) ->
        if status is 'OK'
          latlng = results[0].geometry.location
          map.setCenter latlng.lat(), latlng.lng()
          map.addMarker
            lat: latlng.lat()
            lng: latlng.lng()
            infoWindow: content: '123'
          map.markers[map.markers.length - 1].visible = false
          (map.markers[map.markers.length - 1].infoWindow).open(map, map.markers[map.markers.length - 1])
          map.fitZoom
