# Usage

In the snippet you can see the way to create a chart with axes and data.
Take a look in the sample folder to see more details on how this works.
As this is a fluid interface, you can chain the methods to create the chart you want.
```ruby
data = File.readlines(__dir__ + "/data.csv", chomp: true).map { |line| line.split(",") }

output = Plot.new(data, height: 500, width: 1000)
             #.scatter
             .line
             .title("Legacy JS Lines of Code")
             .x_axis(title: "Date", count: 7)
             .y_axis(title: "Lines of Code", count: 10, grid_lines: true)
             .trend_line
             .to_svg

File.write(__dir__ + "/chart.svg", output)
```
