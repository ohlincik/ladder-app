module ApplicationHelper
	def active_page(page,action)
	  if controller.controller_name.to_s == page && controller.action_name.to_s == action
	    "class=active"
		end
	end
end
