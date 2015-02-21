class NetworkAnalyser
  attr_accessor :results

  SUITES_MAP = {
    hop_distance: :calulate_hop_distances,
    shortest_route: :calculate_shortest_routes,
    number_of_routes: :calculate_number_of_routes
  }

  SEARCH_RECURSIVELY = true

  def initialize(network)
    @network_table = network.suburbs
    @results = []
  end

  # Main method which takes care of analysis
  # It calls specific method for each test
  def perform_analysis
    results = SUITES_MAP.map do |suite, analyser_method|
      perform_tests(RouteTestFactory.test_suite(suite), method(analyser_method))
    end
    @results = results.flatten
  end

  def perform_tests(tests, function)
    if !tests.nil?
      tests.each do |test|
        test.result = function.call(test.condition)
      end
    else
      []
    end
  end


  # Main calculation methods

  def calulate_hop_distances(path)
    distance = 0
    return false unless path
    path.each_cons(2) do |source_node, destination_node|
      node = @network_table[source_node]
      hop_distance = node.distance_to(destination_node) if node
      return false unless hop_distance
      distance += hop_distance
    end

    distance
  end

  def calculate_shortest_routes(path)
    @network_table[path[:source]].distance_to(path[:destination], SEARCH_RECURSIVELY)
  end


  # BFS was chosen over recursion
  def calculate_number_of_routes(path)
    return false unless suite_valid?(path)

    condition = path[:condition]
    range_property = condition[:property]
    range_evaluator = condition[:eval]
    range_value = condition[:value]

    nodes_to_visit_queue = [Route.new(@network_table[path[:source]], @network_table[path[:destination]])]
    routes_counter = 0

    until nodes_to_visit_queue.empty?
      route = nodes_to_visit_queue.shift
      node = route.source

      routes_counter += 1 if path[:destination] == node.name &&
                              route.hop_count.to_i > 0 &&
                            evaluate_property(route, range_property, range_evaluator, range_value)
      next if out_of_range?(route, range_property, range_evaluator, range_value)

      node.neighbours.each { |_key, neighbour| nodes_to_visit_queue.push(route.visit(neighbour.destination)) }
    end
    routes_counter
  end

  private

  def suite_valid?(path_suite)
    return false if path_suite.nil? || path_suite[:condition].nil? ||
                    path_suite[:source].nil? || path_suite[:destination].nil?
    condition = path_suite[:condition]
    return false if condition[:property].nil? || condition[:eval].nil? || condition[:value].nil?

    true
  end

  def evaluate_property(route, property, evaluator, value)
    route.send(property).send(evaluator, value)
  end

  def out_of_range?(route, property, evaluator, value)
    evaluate_property(route, property, '>=', value)
  end
end