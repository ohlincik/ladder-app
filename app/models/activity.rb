class Activity
	def initialize count
		@activity = Match.order(:updated_at).limit(count)
	end
end