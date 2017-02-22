module ApplicationHelper

  def offering_palette(offering)
    if !offering.nil? && !offering.ancestor.panel_color.nil?
      backgrnd = offering.ancestor.panel_color.include?('#') ? offering.ancestor.panel_color : '#797980'
    else
      backgrnd = '#797980'
    end
    return backgrnd
  end

  def next_webinar
    Event.next_webinar
  end

  def pending_preps
    Event.pending('prep')
  end

end
