# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "nsi-abntformat"
  gem.homepage = "http://github.com/oswluiz/nsi-abntformat"
  gem.license = "MIT"
  gem.summary = "ABNT Format"
  gem.description = "Transforms objects containing documentation metadata in bibliographic references on ABNT format"
  gem.email = "oswluizf@gmail.com"
  gem.authors = ["Oswaldo Ferreira"]
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
  spec.rspec_opts = "--color --format nested"
end

task :default => :spec
