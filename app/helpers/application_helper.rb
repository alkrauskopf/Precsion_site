module ApplicationHelper

  def offering_palette(offering)
    if !offering.nil?
      background = offering.ancestor.panel_color[0] == '#' ? offering.ancestor.panel_color : '#797980'
    else
      background = '#ffffff'
    end
    return background
  end

end
