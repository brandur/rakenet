# 
# Project home page:
#
#     http://github.com/fyrerise/rakenet
#
# This software is open source and licensed under the BSD license, see the 
# included LICENSE file for details.
#

# Initialize the Bundler environment, it will handle all other dependencies
require 'rubygems'
require 'bundler'
Bundler.setup

require 'albacore'
require 'mstest_task'
require 'sass/plugin'

# Albacore still defaults to MSBuild 3.5, so specify the exe location manually
MsBuild = 'C:/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe'
WebDev  = 'C:/Program Files/Common Files/microsoft shared/DevServer/10.0/WebDev.WebServer40.EXE'

task :default => :build

desc 'Alias for build:debug'
task :build => 'build:debug'

namespace :build do
  [ :debug, :release ].each do |t|
    desc "Build the CPS solution with #{t} configuration"
    msbuild t do |b|
      b.path_to_command = MsBuild
      b.properties :configuration => t
      b.solution = 'Path/To/My/Solution.sln'
      b.targets :Build
    end
  end
end

desc 'Clean build files from the directory structure'
msbuild :clean do |b|
  b.path_to_command = MsBuild
  b.solution = 'Path/To/My/Solution.sln'
  b.targets :Clean
end

desc 'Alias for test:all'
task :test => 'test:all'

namespace :test do
  desc 'Run all tests'
  # Run the category task with no parameters, and therefore no category
  task :all => 'test:category'

  # Usage -- rake test:category[<category name>]
  desc 'Run all tests in a category'
  mstest :category, :cat, :needs => 'build:debug' do |t, args|
    t.category = args[:cat] if args[:cat]
    t.container = 'Path/To/My/Solution/Tests.dll'
  end
end

desc 'Start a development server'
exec :server => 'build:debug' do |cmd|
  cmd.path_to_command = WebDev
  # Should point to the web directory
  path = 'Path/To/My/Solution'
  # WebDev.WebServer is *extremely* finicky and is a typical example of 
  # fragile Microsoft coding. For it to work, its path MUST (a) use 
  # backslash directory separators, and (b) be absolute. Here we use Cygwin 
  # to convert a relative Unix path to an absolute Windows path.
  path = `cygpath -a -w #{path}`.strip
  cmd.parameters << %-"/path:#{path}"-
  cmd.parameters << %-"/port:3001"-
  puts ''
  puts 'Starting development server on http://localhost:3001'
  puts 'Ctrl-C to shutdown server'
end

desc 'Updates stylesheets if necessary from their Sass templates'
task :sass do
  # @todo: change this once we know our stylesheets location
  Sass::Plugin.add_template_location 'app/'
  Sass::Plugin.on_updating_stylesheet do |template, css|
    puts "Compiling #{template} to #{css}"
  end
  Sass::Plugin.update_stylesheets
end

