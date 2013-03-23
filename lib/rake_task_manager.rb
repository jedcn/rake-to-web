require 'rake'

class RakeTaskManager

  def initialize
    Rake.application.init
    Rake.application.load_rakefile
    @tasks = Rake.application.tasks
  end

  def names
    @tasks.collect { |task| task.name }
  end

  def run(name)
    `rake #{name}`
  end

end
