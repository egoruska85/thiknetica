#class Train
#  attr_accessor :type, :model, :number, :number_of_wagons
#
#  def initialize(number, *args )
#    @number = number
#    @type = args[0] || "Unknown"
#    @model = args[1] || "Unknown"
#    @number_of_wagons = args [2] || "Unknown"
#  end
#end

class Train
  attr_accessor :type, :model, :number, :number_of_wagons

  def initialize(number, option = { })
    @number = number
    @type = option[:type] || "Unknown"
    @model = option[:model] || "Unknown"
    @number_of_wagons = option[:number_of_wagons] || "Unknown"
  end
end

class Foo
  def bar(key)
    h = { a: 1, b: 2}
    value = h[key]
    value ||= 0
  end

  def long_method
    sleep(3)
  end

  def memoization
    @m ||= long_method
  end

end
class User
  attr_accessor :name

  def has_name?
    !!name
  end

  def has_not_name?
    !has_name?
  end

  def name=(value)
    @name = value.capitalize
  end
end
class Color
  COLORS = { red: "#f00", green: "#0f0", blue: "#00f", white: "#fff" }

  def code(name)
    @code = COLORS[name]  || "#000"

  end

  alias_method :by_name, :code
end
