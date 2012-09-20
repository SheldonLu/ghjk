$ ->
	$('#myTab a').click (e) ->
		e.preventDefault()
		$(@).tab('show') 

	$('#ptab a').click ->
		$('ul.nav-tabs li.active').removeClass('active')
		$(@).parent().addClass('active')

	$('#ptab .dropdown a').click ->
		$('#ptab .dropdown').addClass('active')

$(document).ready ->

  $('.itemInfo').on 'mouseover', '.like', ->
    alert 'a'

  $('.itemInfo .like').live 'click', ->
    alert 'a'

  # $(document).on 'hover', '.itemInfo .like',(
  #   ()->
  #     $(this).addClass("like_hover")
  #     # coffee 写法是 this = @
  #     # $(@).addClass("like_hover")
  #     $(this).find("span").html("+1")
  #   ()->
  #     $(this).removeClass("like_hover")
  #     $(this).find("span").html("喜欢")
  # )

    
  # $(".itemInfo .like").bind 'hover',(
  #   ()->
  #     $(this).addClass("like_hover")
  #     # coffee 写法是 this = @
  #     # $(@).addClass("like_hover")
  #     $(this).find("span").html("+1")
  #   ()->
  #     $(this).removeClass("like_hover")
  #     $(this).find("span").html("喜欢")
  # )
