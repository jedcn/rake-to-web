require 'rake'
require 'open3'

class RakeTaskManager

  def initialize
    Rake.application.init
    Rake.application.load_rakefile
    @tasks = Rake.application.tasks
  end

  def names
    @tasks.collect { |task| encode_task_name task.name }
  end

  def run(name)
    run_stderr_stdout, status = Open3.capture2e 'rake', decode_task_name(name)
    run_stderr_stdout
  end

  private

  def encode_task_name(name)
    name.gsub(':', '/')
  end

  def decode_task_name(name)
    name.gsub('/', ':')
  end

end
