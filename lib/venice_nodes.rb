# Source Files
require 'file_analyser/file_analyser'
require 'file_analyser/network_builder'

require 'network/network'
require 'network/node'
require 'network/route'
require 'network/network_analyser'

require 'route_tests/route_test'
require 'route_tests/route_test_factory'

require 'output_formatter/output_formatter'

require 'exceptions/custom_exception'

# Modules
include FileAnalyzer
include NetworkBuilder

class VeniceNodes

  def initialize(data_file)
    @filename = data_file.to_s.strip
  end


  def run
    begin
      network = generate_network(suburbs_from(@filename))
      OutputFormatter.new(NetworkAnalyser.new(network).perform_analysis).display
    rescue => e
        puts "ERROR: #{e.message}"
    end
  end
end
