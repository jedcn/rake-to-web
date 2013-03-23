require_relative 'rake_task_manager'
require_relative 'task_to_web_builder'

rake_task_manager = RakeTaskManager.new
builder = TaskToWebBuilder.new rake_task_manager
builder.app.run!
