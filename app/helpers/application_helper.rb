module ApplicationHelper
	def flash_fields
		html = ''
		html += "<p id=\"notice\">#{notice}</p>" if notice
		html += "<p id=\"alert\">#{alert}</p>" if alert
		html.html_safe
	end
end
