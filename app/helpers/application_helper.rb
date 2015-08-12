module ApplicationHelper
  def comment    
  end
  def glyph(name)
    content_tag :span, '', class:"glyphicon glyphicon-#{name}", aria:{ hidden:"true" }
  end
end
