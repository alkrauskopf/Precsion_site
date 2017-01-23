module ApplicationHelper

  def offering_palette(offering)
 #   if !offering.nil?
    if false
      background = offering.panel_color.include?('#') ? offering.panel_color : '#797980'
    else
      background = '#ffffff'
    end
    return background
  end
end
