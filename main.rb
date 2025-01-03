require "erubi"
require 'date'
require_relative 'src/plot'
require_relative 'src/data_value'
require_relative 'src/axis'

data = File.readlines("data.csv", chomp: true).map { |line| line.split(",") }

output = Plot.new(data, height: 500, width: 1000)
                    #.scatter
                    .line
                    .title("Legacy JS Lines of Code")
                    .x_axis(title: "Date", count: 7)
                    .y_axis(title: "Lines of Code", count: 10, grid_lines: true)
                    .trend_line
                    .to_svg
File.write("chart.svg", output)

puts "complete"
