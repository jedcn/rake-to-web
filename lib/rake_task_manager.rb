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
    @tasks.collect { |task| task.name }
  end

  def run(name)
    `rake #{name}`
  end

# def execute_task(task)
#   require 'ostruct'
#   output = `rake #{task.name}`
#   result = {
#     :output => output,
#     :status => $?
#   }
#   OpenStruct.new result
# end

end
