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
      case tag.tier
      when 0
        tag_url tier_0: tag
      when 1
        tag_url tier_0: [ @tags[0] || 'All' , tag]
      when 2
        tag_url tier_0: [ @tags[0] || 'All', @tags[1] || 'All' , tag]
      when 3
        tag_url tier_0: [ @tags[0] || 'All', @tags[1] || 'All' , @tags[2] || 'All', tag]
      end
    else
      tag_url(tag)
    end
  end

  def markdown(text)
    require 'rdiscount'
    markdown = RDiscount.new(text)
    markdown.to_html.html_safe
  end

  def navigation_links

    links = {
      "/newest" => "Newest",
      "/comments" => "Comments",
      "/search" => "Search"
    }
    if @user
      links.merge!({ "/stories/new" => "Submit resource" })
    end

    if !@user
      links.merge!( '/login' => 'Login' )
    end
    links
  end
end
