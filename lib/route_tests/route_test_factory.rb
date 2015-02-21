class RouteTestFactory

  # TEST CASES DATA

  TEST_DATA = {
    hop_distance: [
      {case: %w(A B C), name: 1},
      {case: %w(A D), name: 2},
      {case: %W(A D C), name: 3},
      {case: %w(A E B C D), name: 4},
      {case: %w(A E D), name: 5}
    ],

    shortest_route: [
      {case: {source: 'A', destination: 'C'}, name: 8},
      {case: {source: 'B', destination: 'B'}, name: 9}
    ],

    number_of_routes: [
      {case: {source: 'C', destination: 'C', condition: {property: :hop_count, eval: '<=', value: 3}}, name: 6},
      {case: {source: 'A', destination: 'C', condition: {property: :hop_count, eval: '==', value: 4}}, name: 7},
      {case: {source: 'C', destination: 'C', condition: {property: :trip_distance, eval: '<', value: 30}}, name: 10}
    ]
  }

  def self.test_suite(suite)
    TEST_DATA[suite].map() { |test| RouteTest.new(test[:name], test[:case]) }
  end
end