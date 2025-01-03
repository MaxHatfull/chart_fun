# frozen_string_literal: true

class Axis
  attr_reader :title, :start_point, :end_point, :grid_lines

  def initialize(min, max, start_point, end_point, count, title, grid_lines)
    @min = min
    @max = max
    @start_point = start_point
    @end_point = end_point
    @type = min.type
    @count = count
    @title = title
    @grid_lines = grid_lines
  end

  def labels
    (0...@count).map do |i|
      value = interpolate(i, 0, @count - 1, @min.value, @max.value)
      {
        text: label_string(value),
        x: perpendicular[0] * 25 + interpolate(i, 0, @count - 1, @start_point[:x], @end_point[:x]),
        y: perpendicular[1] * 25 + interpolate(i, 0, @count - 1, @start_point[:y], @end_point[:y])
      }
    end
  end

  def label_string(x)
    case @type
    when :date
      Time.at(x).strftime("%Y-%m-%d")
    else
      x.to_s
    end
  end

  def title_pos
    {
      x: perpendicular[0] * 75 + (@start_point[:x] + (@end_point[:x] - @start_point[:x]) / 2),
      y: perpendicular[1] * 75 + (@start_point[:y] + (@end_point[:y] - @start_point[:y]) / 2)
    }
  end

  private

  def perpendicular
    direction = [@start_point[:x] - @end_point[:x], @start_point[:y] - @end_point[:y]]
    perpendicular = [direction[1], -direction[0]]
    perpendicular.map { |i| i / Math.sqrt(perpendicular[0] ** 2 + perpendicular[1] ** 2) }
  end

  def interpolate(value, from_low, from_high, to_low, to_high)
    (value - from_low) * (to_high - to_low) / (from_high - from_low) + to_low
  end
end
