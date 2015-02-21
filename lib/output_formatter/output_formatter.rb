class OutputFormatter

  def initialize(results_set)
    @results = results_set
  end

  def display
    @results.sort_by(&:name).each { |result| route_test_display(result) }
  end

  private

  def route_test_display(route_test)
    puts(result_format(route_test))
  end

  def result_format(route_test)
    "##{route_test.name}: #{route_test.result ? route_test.result : "NO SUCH ROUTE"}"
  end
end