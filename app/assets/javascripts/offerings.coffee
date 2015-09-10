$(document) ->
  $(".accordion > dd").hide()
  allPanels = $(".accordion > dd").hide()
  $('.accordion > dt > a').click ->
    allPanels.slideUp()
    $(this).parent().next().slideDown()
    false
  return

  $(document).on 'click', '.api_load a', ->
  $(".ingredients_list").hide()
  $(".ingredients_loading").show()
  $.getScript @href
  false

