$ ->
	$('#myTab a').click (e) ->
		e.preventDefault()
		$(@).tab('show')

	$('#posttab a').click ->
		$('ul.nav-tabs li.active').removeClass('active')
		$(@).parent().addClass('active')

	$('#posttab .dropdown a').click ->
		$('#posttab .dropdown').addClass('active')
