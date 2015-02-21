lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rspec/core/rake_task'
require 'venice_nodes.rb'
require 'rake'

task :run do
  VeniceNodes.new(ARGV[1]).run 
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
#  t.rspec_opts = '--format documentation'
# t.rspec_opts << ' more options'
#  t.rcov = true
end

task :test => :spec
