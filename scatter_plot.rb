# frozen_string_literal: true

class ScatterPlot
  def initialize(data, grid_lines: true)
    @data = data.map { |line| [DataValue.new(line[0]), DataValue.new(line[1])] }
  end

  def title(title)
    @title = title
    self
  end

  def x_axis(title: nil, count: 10, grid_lines: true)
    @x_axis_options = { title: title, count: count, grid_lines: grid_lines }
    self
  end

  def y_axis(title: nil, count: 10, grid_lines: true)
    @y_axis_options = { title: title, count: count, grid_lines: grid_lines }
    self
  end

  def to_svg
    @x_axis = Axis.new(
      min_x,
      max_x,
      { x: plot_area[:left], y: plot_area[:bottom] },
      { x: plot_area[:right], y: plot_area[:bottom] },
      @x_axis_options[:count],
      @x_axis_options[:title],
      @x_axis_options[:grid_lines]
    )

    @y_axis = Axis.new(
      min_y,
      max_y,
      { x: plot_area[:left], y: plot_area[:top] },
      { x: plot_area[:left], y: plot_area[:bottom] },
      @y_axis_options[:count],
      @y_axis_options[:title],
      @y_axis_options[:grid_lines]
    )

    eval(Erubi::Engine.new(File.read('chart.svg.erb')).src)
  end

  private

  def plot_area
    top = @title ? 100 : 50
    left = @y_axis_options&.key?(:title) ? 100 : 50
    right = 950
    bottom = @x_axis_options&.key?(:title) ? 900 : 950
    { top:, left:, right:, bottom: }
  end

  def point_positions
    @data.map do |x, y|
      [
        interpolate(x.value, min_x.value, max_x.value, plot_area[:left], plot_area[:right]),
        interpolate(y.value, min_y.value, max_y.value, plot_area[:bottom], plot_area[:top])
      ]
    end
  end

  def interpolate(value, fromLow, fromHigh, toLow, toHigh)
    (value - fromLow) * (toHigh - toLow) / (fromHigh - fromLow) + toLow
  end

  def x_values = @data.map(&:first)

  def min_x = x_values.min_by(&:value)

  def max_x = x_values.max_by(&:value)

  def y_values = @data.map(&:last)

  def min_y = y_values.min_by(&:value)

  def max_y = y_values.max_by(&:value)
end
