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
  $(".itemInfo .like").hover(
    ()->
      $(this).addClass("like_hover")
      # coffee 写法是 this = @
      # $(@).addClass("like_hover")
      $(this).find("span").html("+1")
    ()->
      $(this).removeClass("like_hover")
      $(this).find("span").html("喜欢")
  )
