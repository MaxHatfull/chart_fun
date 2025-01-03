# frozen_string_literal: true

class Axis
  def initialize(min, max, start_point, end_point, count)
    @min = min
    @max = max
    @start_point = start_point
    @end_point = end_point
    @type = min.type
    @count = count
  end

  def labels
    (0...@count).map do |i|
      value = interpolate(i, 0, @count - 1, @min.value, @max.value)
      {
        text: label_string(value),
        x: interpolate(i, 0, @count - 1, @start_point[:x], @end_point[:x]),
        y: interpolate(i, 0, @count - 1, @start_point[:y], @end_point[:y])
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

  private

  def interpolate(value, from_low, from_high, to_low, to_high)
    (value - from_low) * (to_high - to_low) / (from_high - from_low) + to_low
  end
end
