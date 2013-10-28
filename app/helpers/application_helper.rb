module ApplicationHelper
	def active_page(page,action)
	  if controller.controller_name.to_s == page && controller.action_name.to_s == action
	    "class=active"
		end
	end

	def distance_of_time_in_days(from_time, to_time = 0)
		from_time = from_time.to_time if from_time.respond_to?(:to_time)
		to_time = to_time.to_time if to_time.respond_to?(:to_time)
		from_time, to_time = to_time, from_time if from_time > to_time
		distance_in_days = (((to_time - from_time).abs) / 86400).round
	end

	def display_phone(phone_number)
		if phone_number 
			number_to_phone(phone_number.gsub(/\D/, ''), area_code: true)
		else
			'n/a'
		end
	end
end
