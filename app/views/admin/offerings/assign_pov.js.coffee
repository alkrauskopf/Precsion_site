$(".pov_associations").html("<%= escape_javascript(render('pov_associations')) %>")

$(".pov_association_loading").hide()
$(".pov_associations").show()
