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
  gem.name = "rake-to-web"
  gem.homepage = "https://github.com/jedcn/rake-to-web"
  gem.license = "MIT"
  gem.summary = %Q{A Web Application that knows how to run your Rakefile}
  gem.description = %Q{A Web Application that, when started, runs rake -T, and builds routes for each action. POSTing to a route invokes the action.}
  gem.email = "northridge@gmail.com"
  gem.authors = ["Jed Northridge"]
  gem.files.exclude '.rvmrc'
  gem.files.exclude 'Gemfile', 'Gemfile.lock'
  gem.files.exclude '.rspec'
  gem.files.exclude 'spec/**/*'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec

namespace :to do
  desc 'rake-to-web'
  task :web do
    require 'sinatra/base'
    my_app = Sinatra.new { get('/') { "hi" } }
    my_app.run!
  end
end
