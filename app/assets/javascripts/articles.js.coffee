$ ->
	$('#myTab a').click (e) ->
		e.preventDefault()
		$(@).tab('show') 

	$('#ptab a').click ->
		$('ul.nav-tabs li.active').removeClass('active')
		$(@).parent().addClass('active')

	$('#ptab .dropdown a').click ->
		$('#ptab .dropdown').addClass('active')

