require 'rspec'

describe OutputFormatter do

  it 'should format output' do
    test = RouteTest.new('1', nil)
    test.result = 36
    expect(OutputFormatter.new(nil).send('result_format', test)).to eq("#1: 36")
  end

  it 'should format blank result' do
    test = RouteTest.new('1', nil)
    test.result = nil
    expect(OutputFormatter.new(nil).send('result_format', test)).to eq("#1: NO SUCH ROUTE")
  end
end