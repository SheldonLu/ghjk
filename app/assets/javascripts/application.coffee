#= require jquery
#= require jquery_ujs
#= require jquery.timeago
#= require jquery.timeago.settings
#= require jquery.wookmark
#= require rails.validations
#= require bootstrap
#= require_self

$ ->
	$('#tiles li').wookmark
    autoResize: true,
    container: $('#pmain'), 
    offset: 2, 
    itemWidth: 210 
  