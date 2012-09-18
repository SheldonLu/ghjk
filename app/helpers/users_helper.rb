# coding: utf-8
module UsersHelper

  def user_avatar_width_for_size(size)
    case size
      when :small then 16
      when :normal then 48
      when :large then 64
      when :big then 120
      else size
    end
  end

  def user_avatar_tag(user, size = :normal, opts = {})

    width = user_avatar_width_for_size(size)

    if user.blank?
      # hash = Digest::MD5.hexdigest("") => d41d8cd98f00b204e9800998ecf8427e
      return image_tag("avatar/#{size}.png", :class => "uface")
    end

    # 如果使用gem 'carrierwave-mongoid'
    # 则为 if user[:avatar_filename].blank?
    if user[:avatar].blank?
      default_url = asset_path("avatar/#{size}.png")
      #img_src = "#{Setting.gravatar_proxy}/avatar/#{user.email_md5}.png?s=#{width}&d=404"
      img = image_tag(default_url, :class => "uface", :style => "width:#{width}px;height:#{width}px;")
    else
      img = image_tag(user.avatar.url(size), :class => "uface", :style => "width:#{width}px;height:#{width}px;")
    end

    #link = opts[:link] || true
    link = true
    if link
      raw %(<a href="#{user_path(user.login)}">#{img}</a>)
    else
      raw img
    end
  end
end