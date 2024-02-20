# 0 speed = 221 cars/hour
# 100% success rate 1-4 speed
# 90% success rate 5-8 speed
# 80% success rate 9 speed
# 77% success rate 10 speed

SPEED_RANGE = (0..10)

# Solution 1

def production_rate(speed, success_rate)
  (221 * speed * success_rate.call(speed)).to_i
end

def working_items_per_minute(speed, success_rate)
  (production_rate(speed, success_rate) / 60.0).to_i
end

success_rate = proc do |speed|
  case speed
  when 1..4
    1.0
  when 5..8
    0.9
  when 9
    0.8
  else
    0.77
  end
end

SPEED_RANGE.map do |speed|
  puts "Production rate per hour at speed #{speed}: #{production_rate(speed, success_rate)} cars"
  puts "Working items produced per minute at speed #{speed}: #{working_items_per_minute(speed, success_rate)} cars"
end

=begin
SUCCESS_RATES = {
  (1..4) => 1.0,
  (5..8) => 0.9,
  9 => 0.8,
  10 => 0.77
}.freeze
DEFAULT_SUCCESS_RATE = 0.77
PRODUCTION_RATE_0 = 221

def production_rate(speed)
  success_rate = SUCCESS_RATES.find { |range, _| range === speed }&.last
  (PRODUCTION_RATE_0 * speed * success_rate).to_i
end

def working_items_per_minute(speed)
  (production_rate(speed) / 60.0).to_i
end

SPEED_RANGE.map do |speed|
  puts "Production rate per hour at speed #{speed}: #{production_rate(speed)} cars"
  puts "Working items produced per minute at speed #{speed}: #{working_items_per_minute(speed)} cars"
end
=end
