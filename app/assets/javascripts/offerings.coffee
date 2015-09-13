# 'dom'
$(document) ->
  $(".accordion > dd").hide()
  allPanels = $(".accordion > dd").hide()
  $('.accordion > dt > a').click ->
    allPanels.slideUp()
    $(this).parent().next().slideDown()
    false
  return

$(document).on 'click', '.pov_load a', ->
  $(".pov_associations").hide()
  $(".pov_association_loading").show()
  $.getScript @href
  false

