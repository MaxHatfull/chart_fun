# frozen_string_literal: true

class DataValue
  attr_reader :type

  def initialize(value)
    @value = value
    @type = if date_time?(value)
              :date
            elsif Integer(value)
              :integer
            else
              :string
            end
  end

  def value
    case @type
    when :date
      DateTime.parse(@value).to_time.to_i
    else
      @value.to_i
    end
  end

  def to_s
    @value.to_s
  end

  private

  def date_time?(val)
    DateTime.parse(val)
    true
  rescue Date::Error
    false
  end
end
