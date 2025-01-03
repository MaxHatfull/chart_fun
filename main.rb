require "erubi"
require 'date'
require_relative 'plot'
require_relative 'data_value'
require_relative 'axis'

data = File.readlines("data.csv", chomp: true).map { |line| line.split(",") }

output = Plot.new(data)
                    #.scatter
                    .line
                    .title("Legacy JS Lines of Code")
                    .x_axis(title: "Date", count: 6)
                    .y_axis(title: "Lines of Code", count: 10)
                    .trend_line
                    .to_svg
File.write("chart.svg", output)

puts "complete"
