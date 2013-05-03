[Time, Date].map do |klass|
	klass::DATE_FORMATS[:short_ordinal] = lambda { |t| t.strftime("%B #{t.day.ordinalize}") }
end