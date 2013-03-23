require 'spec_helper'

describe RakeTaskManager do

  it 'knows about defined rake tasks' do
    rake_task_manager = RakeTaskManager.new
    rake_task_manager.names.should include 'hello_world'
  end

  it 'knows how to run defined rake tasks' do
    rake_task_manager = RakeTaskManager.new
    rake_task_manager.should_receive(:`).with('rake hello_world')
    rake_task_manager.run 'hello_world'
  end

end
