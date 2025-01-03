# frozen_string_literal: true

class ScatterPlot
  def initialize(data)
    @data = data.map do |line|
      [
        Date.parse(line[0]).to_time.to_i,
        line[1].to_i
      ]
    end
  end

  def to_svg
    eval(Erubi::Engine.new(File.read('chart.svg.erb')).src)
  end

  private

  def plot_area
    {
      top: 50, right: 950, bottom: 950, left: 50,
      width: 900, height: 900
    }
  end

  def y_axis_labels
    (0..10).map do |i|
      y = interpolate(i, 0, 10, min_y, max_y)
      {
        text: y,
        x: plot_area[:left] / 2,
        y: interpolate(i, 0, 10, plot_area[:bottom], plot_area[:top])
      }
    end
  end

  def x_axis_labels
    (0..10).map do |i|
      x = interpolate(i, 0, 10, min_x, max_x)
      {
        text: Time.at(x).to_date,
        x: interpolate(i, 0, 10, plot_area[:left], plot_area[:right]),
        y: (plot_area[:top] / 2) + plot_area[:bottom]
      }
    end
  end

  def point_positions
    @data.map do |x, y|
      [
        interpolate(x, min_x, max_x, plot_area[:left], plot_area[:right]),
        interpolate(y, min_y, max_y, plot_area[:bottom], plot_area[:top])
      ]
    end
  end

  def interpolate(value, fromLow, fromHigh, toLow, toHigh)
    (value - fromLow) * (toHigh - toLow) / (fromHigh - fromLow) + toLow
  end

  def x_values = @data.map(&:first)
  def min_x = x_values.min
  def max_x = x_values.max

  def y_values = @data.map(&:last)
  def min_y = y_values.min
  def max_y = y_values.max
end
