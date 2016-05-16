# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  odometer = $('.odometer')
  value = +odometer.text()
  odometer.on 'click', ->
    value += 10
    odometer.html(value)