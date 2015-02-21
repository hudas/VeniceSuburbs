class RouteTest
  attr_accessor :name, :condition, :result

  def initialize(name, condition)
    @name = name
    @condition = condition
    @result = 0
  end

end