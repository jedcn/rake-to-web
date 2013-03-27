require 'spec_helper'

describe RakeTaskManager do

  it 'knows about defined rake tasks' do
    rake_task_manager = RakeTaskManager.new
    rake_task_manager.names.should include 'examples/hello_world'
  end

  it 'knows how to run defined rake tasks' do
    rake_task_manager = RakeTaskManager.new
    Open3.should_receive(:capture2e).with('rake', 'examples:hello_world')
    rake_task_manager.run 'examples/hello_world'
  end

end
