require 'rspec'

describe NetworkAnalyser do

  before :each do
    @network = Network.new

    @node_a = NetworkNode.new('A')
    @node_b = NetworkNode.new('B')
    @node_c = NetworkNode.new('C')
    @node_d = NetworkNode.new('D')

    @network.add_route(Route.new(@node_a, @node_b, 5))
    @network.add_route(Route.new(@node_b, @node_c, 5))

    @analyzer = NetworkAnalyser.new(@network)
  end

  describe '.calulate_hop_distances' do

    it 'should find distance' do
      @network.add_route(Route.new(@node_b, @node_d, 7))

      expect(@analyzer.calulate_hop_distances(%w(A B D))).to eq(12)
    end

    it 'should return valid result when nodes unreachable' do
      expect(@analyzer.calulate_hop_distances(%w(A B D))).to eq(false)
    end

    it 'should return valid result when nodes list blank ' do
      expect(@analyzer.calulate_hop_distances(nil)).to eq(false)
    end

    it 'should return valid result when nodes list empty ' do
      expect(@analyzer.calulate_hop_distances(nil)).to eq(false)
    end

    it 'should return valid result when nodes in list invalid' do
      expect(@analyzer.calulate_hop_distances([457, 'invalid_string'])).to eq(false)
    end

  end

  describe '.calculate_number_of_routes' do

    before :each do
      @network.add_route(Route.new(@node_c, @node_d, 5))
      @network.add_route(Route.new(@node_a, @node_c, 5))
      @network.add_route(Route.new(@node_a, @node_d, 5))
    end

    it 'should find number of rautes' do
      expect(@analyzer.calculate_number_of_routes({source: 'A', destination: 'D', condition: {property: :hop_count, eval: '<=', value: 10}})).to eq(3)
    end

    it 'should find number of routes when limited hop_count with <=' do
      expect(@analyzer.calculate_number_of_routes({
                          source: 'A',
                          destination: 'D',
                          condition: {property: :hop_count, eval: '<=', value: 2}
                      })).to eq(2)
    end

    it 'should find number of routes when limited hop_count with <' do
      expect(@analyzer.calculate_number_of_routes({
                                                  source: 'A',
                                                  destination: 'D',
                                                  condition: {property: :hop_count, eval: '<', value: 2}
                                              })).to eq(1)
    end

    it 'should find number of routes when limited hop_count with ==' do
      expect(@analyzer.calculate_number_of_routes({
                                                  source: 'A',
                                                  destination: 'D',
                                                  condition: {property: :hop_count, eval: '==', value: 2}
                                              })).to eq(1)
    end

    it 'should find number of routes when limited distance with <=' do
      expect(@analyzer.calculate_number_of_routes({
                                                  source: 'A',
                                                  destination: 'D',
                                                  condition: {property: :trip_distance, eval: '<=', value: 10}
                                              })).to eq(2)
    end

    it 'should find number of routes when limited distance with <' do
      expect(@analyzer.calculate_number_of_routes({
                                                  source: 'A',
                                                  destination: 'D',
                                                  condition: {property: :trip_distance, eval: '<', value: 10}
                                              })).to eq(1)
    end

    it 'should find number of routes when limited distance with ==' do
      expect(@analyzer.calculate_number_of_routes({
                                                  source: 'A',
                                                  destination: 'D',
                                                  condition: {property: :trip_distance, eval: '==', value: 10}
                                              })).to eq(1)
    end

    it 'should return valid result when condition blank' do
      expect(@analyzer.calculate_number_of_routes(nil)).to eq(false)
    end

    it 'should return valid result when source is blank' do
      expect(@analyzer.calculate_number_of_routes({
                                                  source: nil,
                                                  destination: 'D',
                                                  condition: {property: :hop_count, eval: '==', value: 10}
                                              })).to eq(false)
    end

    it 'should return valid result when destination is blank' do
      expect(@analyzer.calculate_number_of_routes({
                                                  source: 'A',
                                                  destination: nil,
                                                  condition: {property: :hop_count, eval: '==', value: 10}
                                              })).to eq(false)
    end

    it 'should return valid result when condition is blank' do
      expect(@analyzer.calculate_number_of_routes({
                                                  source: 'A',
                                                  destination: 'D',
                                                  condition: nil
                                              })).to eq(false)
    end

    it 'should return valid result when condition property is blank' do
       expect(@analyzer.calculate_number_of_routes({
                                                  source: 'A',
                                                  destination: 'D',
                                                  condition: {property: nil, eval: '==', value: 10}
                                              })).to eq(false)
    end

    it 'should return valid result when condition evaluator is blank' do
      expect(@analyzer.calculate_number_of_routes({
                                                  source: 'A',
                                                  destination: 'D',
                                                  condition: {property: :hop_count, eval: nil, value: 10}
                                              })).to eq(false)
    end

    it 'should return valid result when condition value is blank' do
      expect(@analyzer.calculate_number_of_routes({
                                                  source: 'A',
                                                  destination: 'D',
                                                  condition: {property: :hop_count, eval: '==', value: nil}
                                              })).to eq(false)
    end

    it 'should return valid result when condition evaluator is blank' do
      @network.add_route(Route.new(@node_b, @node_a, 5))

      expect(@analyzer.calculate_number_of_routes({
                                                  source: 'A',
                                                  destination: 'C',
                                                  condition: {property: :hop_count, eval: '<=', value: nil}
                                              })).to eq(false)
    end

    it 'should return valid result when condition value is blank' do
      expect(@analyzer.calculate_number_of_routes({
                                                  source: 'E',
                                                  destination: 'D',
                                                  condition: {property: :hop_count, eval: '==', value: nil}
                                              })).to eq(false)
    end

    it 'should return valid result when condition value is blank' do
      expect(@analyzer.calculate_number_of_routes({
                                                  source: 'A',
                                                  destination: 'E',
                                                  condition: {property: :hop_count, eval: '==', value: nil}
                                              })).to eq(false)
    end
  end
end