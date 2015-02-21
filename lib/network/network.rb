class Network
  attr_accessor :suburbs

  def initialize
    @suburbs = {}
  end

  def add_route(route)
    if route && route.valid?
      source = route.source
      destination = route.destination

      @suburbs[source.name] ||= source
      @suburbs[destination.name] ||= destination

      @suburbs[source.name].add_route(route)
    end
  end
end