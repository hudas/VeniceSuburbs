require 'rspec'
require_relative './spec_helper'

describe NetworkBuilder do

  before :each do
    @network_array = ['AB1', 'BC2', 'AC3', 'CB4']
    @original_network = generate_network(@network_array)
  end

  describe '.generate_network' do
    it 'should generate blank network' do
      blank_array = nil
      network = generate_network(blank_array)
      expect(network).not_to eq(nil)
      expect(network.suburbs.size).to eq(0)
    end

    it 'should generate unique network routes' do
      routes_from_a = @original_network.suburbs['A'].neighbours.size
      trip_distance_ab = @original_network.suburbs['A'].neighbours['B'].trip_distance
      # Second Route From A to B
      @network_array << 'AB5'
      network = generate_network(@network_array)
      # Routes Shouldn't have changed
      expect(network.suburbs['A'].neighbours.size).to eq(routes_from_a)
      expect(network.suburbs['A'].neighbours['B'].trip_distance).to eq(trip_distance_ab)
    end

    it 'should generate unique network nodes' do
      original_nodes_count = @original_network.suburbs.size

      # Second Route From A to B
      @network_array << 'AB5'
      network = generate_network(@network_array)
      # New Nodes Shouldn't have been added
      expect(network.suburbs.size).to eq(original_nodes_count)
    end

    it 'should not generate blank nodes' do
      original_nodes_count = @original_network.suburbs.size

      @network_array << ''

      network = generate_network(@network_array)
      expect(network.suburbs.size).to eq(original_nodes_count)
    end

    it 'should not generate routes to self' do
      @network_array << 'AA5'

      expect{generate_network(@network_array)}.to raise_error(CustomError)
    end

    it 'should alow only positive distances' do
      @network_array << 'CA-5'

      expect{generate_network(@network_array)}.to raise_error(CustomError)
    end

    it 'should not alow blank distances' do
      @network_array << 'CA'

      expect{generate_network(@network_array)}.to raise_error(CustomError)
    end

    it 'should not alow non numerical distances' do
      @network_array << 'CAstring'

      expect{generate_network(@network_array)}.to raise_error(CustomError)
    end

    it 'should not alow invalid format' do
      @network_array << '15AA'

      expect{generate_network(@network_array)}.to raise_error(CustomError)
    end
  end
end