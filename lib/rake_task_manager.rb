require 'rake'

class RakeTaskManager

  def initialize
    Rake.application.init
    Rake.application.load_rakefile
    @tasks = Rake.application.tasks
  end

  def tasks
    @tasks
  end

  def names
    @tasks.collect { |task| encode_task_name task.name }
  end

  def run(name)
    `rake #{decode_task_name name}`
  end

  private

  def encode_task_name(name)
    name.gsub(':', '/')
  end

  def decode_task_name(name)
    name.gsub('/', ':')
  end

end
