[Time, Date].map do |klass|
	klass::DATE_FORMATS[:short_ordinal] = lambda { |t| t.strftime("%B #{t.day.ordinalize}") }
	klass::DATE_FORMATS[:mini] = lambda { |t| t.strftime("%b %-d") }
end