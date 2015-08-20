# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'click', '.send_contact_us a', ->
  $(".contact-us-form").hide()
  $(".emailing").show()
  $.getScript @href
  false
