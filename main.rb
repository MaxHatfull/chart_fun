require "erubi"
require 'date'
require_relative 'scatter_plot'
require_relative 'data_value'
require_relative 'axis'

data = File.readlines("data.csv", chomp: true).map { |line| line.split(",") }

output = ScatterPlot
           .new(data,
                title: "Legacy JS lines",
                x_title: "Date",
                y_title: "Lines"
           ).to_svg
File.write("chart.svg", output)

puts "complete"
