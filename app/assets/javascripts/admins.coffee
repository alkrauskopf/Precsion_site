# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'click', '.pov_load a', ->
  $(".pov_associations").hide()
  $(".pov_association_loading").show()
  $.getScript @href
  false
