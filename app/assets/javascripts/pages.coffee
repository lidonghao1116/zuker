# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.advanced_search_fields').toggle()
  $('.advanced_search_link').click ->
    $('.advanced_search_fields').toggle()