require 'rspec'

describe 'My behaviour' do

  describe '.add_route' do

    before :each do
      @network = Network.new
      @node_a = NetworkNode.new('A')
      @node_b = NetworkNode.new('B')
      @node_c = NetworkNode.new('C')
    end

    it 'should add routes' do
      suburbs_count = @network.suburbs.size
      route = Route.new(@node_a, @node_b, 10)
      @network.add_route(route)
      expect(@network.suburbs.size).to eq(suburbs_count + 2)
      expect(@network.suburbs['A'].neighbours['B'].source).to equal(@node_a)
      expect(@network.suburbs['A'].neighbours['B'].destination).to equal(@node_b)
    end

    it 'should not add blank route ' do
      suburbs_count = @network.suburbs.size
      route = nil
      @network.add_route(route)
      expect(@network.suburbs.size).to eq(suburbs_count)
    end

    it 'should not add route without distance' do
      suburbs_count = @network.suburbs.size
      route = Route.new(@node_a, @node_b, nil)
      @network.add_route(route)
      expect(@network.suburbs.size).to eq(suburbs_count)
    end

    it 'should not add route with zero distance' do
      suburbs_count = @network.suburbs.size
      route = Route.new(@node_a, @node_b, 0)
      @network.add_route(route)
      expect(@network.suburbs.size).to eq(suburbs_count)
    end

    it 'should not add route with less than zero distance' do
      suburbs_count = @network.suburbs.size
      route = Route.new(@node_a, @node_b, -5)
      @network.add_route(route)
      expect(@network.suburbs.size).to eq(suburbs_count)
    end

    it 'should not add route without destination' do
      suburbs_count = @network.suburbs.size
      route = Route.new(@node_a, nil, 10)
      @network.add_route(route)
      expect(@network.suburbs.size).to eq(suburbs_count)
    end

    it 'should not add route without source' do
      suburbs_count = @network.suburbs.size
      route = Route.new(nil, @node_b, 10)
      @network.add_route(route)
      expect(@network.suburbs.size).to eq(suburbs_count)
    end

    it 'should not create new nodes if source and destination is present' do
      @network.add_route(Route.new(@node_a, @node_c, 10))
      @network.add_route(Route.new(@node_b, @node_a, 10))

      suburbs_count = @network.suburbs.size

      route = Route.new(@node_a, @node_b, 10)
      @network.add_route(route)
      expect(@network.suburbs.size).to eq(suburbs_count)
    end
  end
end