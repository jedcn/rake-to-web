require_relative 'rake_task_manager'
require_relative 'task_to_web_builder'

require 'rake'

task = Rake::Task.define_task 'to-web' do
  require 'rake-to-web'
  rake_task_manager = RakeTaskManager.new
  builder = TaskToWebBuilder.new rake_task_manager
  builder.app.run!
end
task.add_description 'rake to-web'
