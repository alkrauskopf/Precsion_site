module ApplicationHelper

  def offering_palette(offering)
    background = offering.ancestor.panel_color[0] == '#' ? offering.ancestor.panel_color : '#797980'
    return background
  end

end
