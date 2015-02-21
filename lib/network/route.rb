class Route
  attr_accessor :source, :destination, :trip_distance, :hoped_nodes, :hop_count

  def initialize(source, destination, trip_distance = 0, hop_count = 0)
    @source = source
    @destination = destination
    @trip_distance = trip_distance
    @hop_count = hop_count
    @hoped_nodes = []
  end

  def visit(hop_destination)
    route = Route.new(hop_destination,
                      @destination,
                      @trip_distance + @source.distance_to(hop_destination.name),
                      @hop_count + 1)
    route.hoped_nodes = @hoped_nodes + [hop_destination.name]
    route
  end

  def valid?
    source && destination && trip_distance.to_i > 0
  end

end