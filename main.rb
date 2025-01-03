require "erubi"
require 'date'

data = File.readlines("data.csv", chomp: true).map { |line| line.split(",") }
x_values = data.map { |line| line[0] }
               .map { |value| Date.parse(value).to_time.to_i }
y_values = data.map { |line| line[1] }

max_y = y_values.max.to_i
min_y = y_values.min.to_i

max_x = x_values.max.to_i
min_x = x_values.min.to_i

def interpolate(value, fromLow, fromHigh, toLow, toHigh)
  (value - fromLow) * (toHigh - toLow) / (fromHigh - fromLow) + toLow
end

output = eval(Erubi::Engine.new(File.read('chart.svg.erb')).src)
File.write("chart.svg", output)

puts "complete"
