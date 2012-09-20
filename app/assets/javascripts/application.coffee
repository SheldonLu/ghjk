#= require jquery
#= require jquery_ujs
#= require jquery.timeago
#= require jquery.timeago.settings
#= require jquery.wookmark
#= require grid
#= require rails.validations
#= require bootstrap
#= require_self
window.App =
  loading : () ->
    console.log "loading..."

  # 警告信息显示, to 显示在那个dom前(可以用 css selector)
  alert : (msg,to) ->
    $(".alert").remove()
    $(to).before("<div class='alert'><a class='close' href='#' data-dismiss='alert'>X</a>#{msg}</div>")

  likeable : (el) ->
    $el = $(el)
    likeable_type = $el.data("type")
    likeable_id = $el.data("id")
    likes_count = parseInt($el.data("count"))
    if $el.data("state") != "liked"
      alert "liked"
      $.ajax
        url : "/likes"
        type : "POST"
        data :
          type : likeable_type
          id : likeable_id

      likes_count += 1
      $el.data('count', likes_count)
      App.likeableAsLiked(el)
    else
      alert "unliked"
      $.ajax
        url : "/likes/#{likeable_id}"
        type : "DELETE"
        data :
          type : likeable_type
      if likes_count > 0
        likes_count -= 1
      $el.data("state","").data('count', likes_count).attr("title", "喜欢")
      if likes_count == 0
        $('span',el).text("喜欢")
      else
        $('span',el).text("#{likes_count}人喜欢")
      $("i.icon",el).attr("class","icon small_like")
    false

    likeableAsLiked : (el) ->
      likes_count = $(el).data("count")
      $(el).data("state","liked").attr("title", "取消喜欢")
      $('span',el).text("#{likes_count}人喜欢")
      $("i.icon",el).attr("class","icon small_liked")

