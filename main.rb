require "erubi"
require 'date'
require_relative 'scatter_plot'

data = File.readlines("data.csv", chomp: true).map { |line| line.split(",") }

output = ScatterPlot.new(data).to_svg
File.write("chart.svg", output)

puts "complete"
