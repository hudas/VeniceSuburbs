class NetworkNode
  attr_accessor :name, :neighbours

  def initialize(name)
    @neighbours = {}
    @name = name
  end

  def add_route(route)
    @neighbours[route.destination.name] ||= route
  end

  def distance_to(destination_node, search_recursively = false)
    if search_recursively
      recursive_search(destination_node)
    elsif @neighbours.key?(destination_node)
      @neighbours[destination_node].trip_distance.to_i
    end
  end

  # Much Recursion, Such WOW
  def recursive_search(destination_node, visited_nodes = [], min_distance = nil, distance = 0)
    visited_nodes << name if distance > 0

    @neighbours.each do |neighbour_name, neighbour|
      # Surely Shortest route can't include loops
      next if visited_nodes.include?(neighbour_name)

      distance += neighbour.trip_distance.to_i

      # Get Result if it's destination node Or Dig in deeper
      if neighbour_name == destination_node
        min_distance = distance if distance < min_distance.to_i || min_distance.nil?
      else
        min_distance = neighbour.destination.recursive_search(destination_node, visited_nodes, min_distance, distance)
      end

      # Restore distance state when get one level back
      distance -= neighbour.trip_distance.to_i
    end

    # Before Leaving this level we should remove object from visited nodes
    # Leaving this object in place would prevent visiting this node from other branch
    visited_nodes.pop()
    min_distance
  end
end