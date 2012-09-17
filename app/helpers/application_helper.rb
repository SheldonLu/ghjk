module ApplicationHelper
  def notice_message
    #flash_messages = []
    #
    #flash.each do |type, message|
    #  type = :success if type == :notice
    #  text = content_tag(:div, link_to("x", "#", :class => "close", 'data-dismiss' => "alert") + message, :class => "alert alert-#{type}")
    #  flash_messages << text if message
    #end
    #
    #flash_messages.join("\n").html_safe
  end

  def controller_stylesheet_link_tag
    case controller_name
      when "users","home", "articles"
        stylesheet_link_tag controller_name
      when "replies"
        stylesheet_link_tag "articles"
    end
  end

  def controller_javascript_include_tag
    case controller_name
      when "articles", "notifications"
        javascript_include_tag controller_name
      when "replies"
        javascript_include_tag "articles"
    end
  end

  def admin?(user = nil)
    user ||= current_user
    user.try(:admin?)
  end

  def wiki_editor?(user = nil)
    user ||= current_user
    user.try(:wiki_editor?)
  end

  def owner?(item)
    return false if item.blank? or current_user.blank?
    item.user_id == current_user.id
  end

  def timeago(time, options = {})
    options[:class]
    options[:class] = options[:class].blank? ? "timeago" : [options[:class],"timeago"].join(" ")
    content_tag(:abbr, "", options.merge(:title => time.iso8601)) if time
  end

  def render_page_title
    title = @page_title ? "#{@page_title} | #{SITE_NAME}" : SITE_NAME rescue "SITE_NAME"
    content_tag("title", title, nil, false)
  end

end