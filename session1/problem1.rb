# Solution 1
WEEK_COUNTS = [0, 2, 5, 3, 7, 8, 4]

# this week bird visit counts
puts "This week bird visit counts: #{WEEK_COUNTS}"
# yesterday bird visit counts
puts "Yesterday bird visit counts: #{WEEK_COUNTS.last}"
# total number of visiting birds
puts "Total number of visiting birds: #{WEEK_COUNTS.sum}"
# number of days where five or more birds visited
puts "Number of days where five or more birds visited: #{WEEK_COUNTS.count { |c| c >= 5 }}"
# days without birds
puts "Days without birds: #{WEEK_COUNTS.count { |c| c == 0 }}"

# Solution 2

class BirdWatcher
  def initialize(weekly_counts)
    @weekly_counts = weekly_counts
  end

  def this_week_counts
    @weekly_counts
  end

  def yesterday_counts
    @weekly_counts[-1]
  end

  def total_visits
    @weekly_counts.sum
  end

  def days_with_five_or_more_visits
    @weekly_counts.count { |count| count >= 5 }
  end

  def days_without_visits
    @weekly_counts.count(0)
  end
end

bird_watcher = BirdWatcher.new(WEEK_COUNTS)

puts "This week bird visit counts: #{bird_watcher.this_week_counts}"
puts "Yesterday bird visit counts: #{bird_watcher.yesterday_counts}"
puts "Total number of visiting birds: #{bird_watcher.total_visits}"
puts "Number of days where five or more birds visited: #{bird_watcher.days_with_five_or_more_visits}"
puts "Number of days without birds: #{bird_watcher.days_without_visits}"
