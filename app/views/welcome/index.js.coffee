alert('hi')
$(".welcome").html("<%= escape_javascript(render('welcome')) %>")

$(".ajax_loading").hide()
$(".welcome").show()
