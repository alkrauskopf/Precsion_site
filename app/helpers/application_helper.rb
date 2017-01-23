module ApplicationHelper

  def offering_palette(offering)
    if !offering.nil? && !offering.ancestor.panel_color.nil?
      backgrnd = offering.ancestor.panel_color.include?('#') ? offering.ancestor.panel_color : '#797980'
    else
      backgrnd = '#ffffff'
    end
    return backgrnd
  end
end
