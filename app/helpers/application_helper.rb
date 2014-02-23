module ApplicationHelper
  def errors_for(object, message=nil)
    html = ""
    unless object.errors.blank?
      html << "<div class=\"flash-error\">\n"
      object.errors.full_messages.each do |error|
        html << error << "<br>"
      end
      html << "</div>\n"
    end

    raw(html)
  end

  def time_ago_in_words_label(*args)
    label_tag(nil, time_ago_in_words(*args),
      :title => args.first.strftime("%F %T %z"))
  end

  def tag_url_with_category(tag)
    if @tags
      tgs = @tags[0...tag.tier] + [tag]
      tag_url tier_0: tgs
    else
      tag_url(tag)
    end
  end

  def markdown(text)
    require 'rdiscount'
    markdown = RDiscount.new(text)
    markdown.to_html.html_safe
  end
end
