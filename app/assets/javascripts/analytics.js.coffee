# z http://kapilrajnakhwa.com/blogs/google-analytics-for-rails-4-and-turbolinks
$(document).on 'page:change', ->
	if window._gaq?
		_gaq.push ['_trackPageview']
	else if window.pageTracker?
		pageTracker._trackPageview()