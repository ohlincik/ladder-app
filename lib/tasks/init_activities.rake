desc "Initialize Activities from existing Matches"
task :init_activities => :environment do
  activities = Activity.all.length
  if activities == 0
    puts "There are no activities. Starting Migration."
    Match.all.each do |match|
      activity = Activity.new
      activity.challenge_issued match
      activity.save
      if match.winner?
        activity = Activity.new
        activity.challenge_completed match
        activity.save
      end
    end
  else
    puts "Activities already exist. Aborting the task !!!"
  end
end