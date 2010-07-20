# 
# Project home page:
#
#     http://github.com/fyrerise/rakenet
#
# This software is open source and licensed under the BSD license, see the 
# included LICENSE file for details.
#

require 'albacore/support/albacore_helper'

MsTest = 'C:/Program Files/Microsoft Visual Studio 10.0/Common7/IDE/MSTest.exe'

create_task :mstest, Proc.new { MSTest.new } do |mstest|
  mstest.run
end

class MSTest
  extend AttrMethods
  include Logging
  include RunCommand
  include YAMLConfig

  attr_accessor :category, :container, :results

  def initialize
    @path_to_command = MsTest
    super()
  end
  
  def run
    command_parameters = []
    command_parameters << %-"/category:#{@category}"- unless @category.nil?
    command_parameters << %-"/resultsfile:#{@results}"- unless @results.nil?
    command_parameters << %-"/testcontainer:#{@container}"- unless @container.nil?

    puts "Parameters #{command_parameters.join(' ')}"
    result = run_command 'MSTest', command_parameters.join(' ')

    failure_message = 'MSTest failed. See build log for detail.'
    fail_with_message failure_message if !result
  end
end

