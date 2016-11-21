# alert('okok')

$(document).on "click", ".clickme", ->
  alert("button clicked!")

$('.clickable').on('click', (ev) ->
  alert('Clicked')
)

$(document).on "click", ".show_offeringx", ->
  alert('refresh')
  jQ.get 'welcome_refresh_url', {}, (data) ->
    jQ('#welcome_page').html data
    jQ('#welcome_page').show()
    return
  return

$(document).ready ->
  $('.show_offering').click ->
    alert('refresh_new')
    $.get 'welcome_refresh_url', {}, (data) ->
      $('#welcome_page').html data
      $('#welcome_page').show()
      return
    return
  return