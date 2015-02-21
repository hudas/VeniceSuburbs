module NetworkBuilder

  # Regex For Two chars and valid numeric value
  VALID_FORMAT = /^[a-zA-Z]{2}(\d*[1-9]+\d*|[1-9])$/

  SOURCE_NODE_INDEX = 0
  DESTINATION_NODE_INDEX = 1
  NUMBER_OF_ENCODED_NODES = 2

  def generate_network(nodes_array)
    @network = Network.new
    unless nodes_array.nil?
      nodes_array.each do |route|
        if !route.nil? && !route.empty?
          validate_route(route)
          @network.add_route(deserialize_route(route))
        end
      end
    end
    @network
  end

  private

  def deserialize_route(route)
    source_key = route[SOURCE_NODE_INDEX]
    destination_key = route[DESTINATION_NODE_INDEX]

    Route.new(
        @network.suburbs[source_key] || NetworkNode.new(source_key),
        @network.suburbs[destination_key] || NetworkNode.new(destination_key),
        route[NUMBER_OF_ENCODED_NODES, route.length]
    )
  end

  def validate_route(route)
    raise(CustomError.new, 'Invalid Input Format') unless valid_format?(route)
    raise(CustomError.new, 'Invalid Route') unless valid_route?(route)
  end

  def valid_format?(route)
    route =~ VALID_FORMAT
  end

  def valid_route?(route)
    route[SOURCE_NODE_INDEX].to_s != route[DESTINATION_NODE_INDEX].to_s
  end
end