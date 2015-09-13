$(".pov_associations").html("<%= escape_javascript(render partial: 'pov_associations', locals: { offering: @offering, povs: @offering.user_povs, avail_povs: @offering.available_povs}) %>")

$(".pov_association_loading").hide()
$(".pov_associations").show()
