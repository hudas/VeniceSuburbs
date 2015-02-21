require 'rspec'

describe 'My behaviour' do

  before :each do
    @network = Network.new

    @node_a = NetworkNode.new('A')
    @node_b = NetworkNode.new('B')
    @node_c = NetworkNode.new('C')
    @node_d = NetworkNode.new('D')
  end

  describe "Distance calculation to one hop neighbours" do
    it 'should find distance to neighbour' do
      @network.add_route(Route.new(@node_a, @node_b, 5))
      @network.add_route(Route.new(@node_b, @node_a, 6))

      expect(@node_a.distance_to('B')).to eq(5)
    end

    it 'should set valid result to non exsistant neighbour' do
      expect(@node_a.distance_to(nil)).to eq(nil)
    end

    it 'should set valid result to unreachable neighbour' do
      expect(@node_a.distance_to('B')).to eq(nil)
    end
  end

  describe "Distace calculation to remote neighbours" do
    it 'should find shorter distance with more hops to distant neighbour' do
      @network.add_route(Route.new(@node_a, @node_b, 5))
      @network.add_route(Route.new(@node_b, @node_c, 2))
      @network.add_route(Route.new(@node_a, @node_c, 8))

      # Route trough b needs 2 hops, however is shorter, 5+2<8
      expect(@node_a.distance_to('C', true)).to eq(7)
    end

    it 'should set valid result to non exsistant distant neighbour' do
      expect(@node_a.distance_to(nil, true)).to eq(nil)
    end

    it 'should set valid result to unreachable distant neighbour' do
      # Cycle in graph to check how will it cope with loops
      @network.add_route(Route.new(@node_a, @node_b, 5))
      @network.add_route(Route.new(@node_b, @node_a, 2))

      @network.add_route(Route.new(@node_b, @node_c, 8))
      @network.add_route(Route.new(@node_a, @node_c, 16))

      expect(@node_a.distance_to('D', true)).to eq(nil)
    end
  end

end