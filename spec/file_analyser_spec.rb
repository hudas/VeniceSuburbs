require 'rspec'
require_relative './spec_helper'

describe 'Analyze Files' do
  describe '#suburbs_from' do
    it 'should manage invalid files' do
      expect{suburbs_from("File_that_doesn't_exsist")}.to raise_error(CustomError)
    end
  end

  describe '#suburbs_from' do
    it 'should ignore whitespaces and process multiline files' do
      expect(suburbs_from("spec/test_file.txt")).to eq(['AB5', 'BC4', 'CD8', 'DC8', 'DE6', 'AD5'])
    end
  end
end