require 'sinatra/base'

class TaskToWebBuilder

  def initialize(task_manager)
    @task_manager = task_manager
  end

  def app
    task_manager = @task_manager
    app = Sinatra.new do

      set :bind, 'localhost'

      set :haml, :format => :html5

      lib = File.dirname __FILE__
      set :views, File.join(lib, 'app', 'views')

      get('/') do
        @tasks = task_manager.tasks
        haml :index
      end

      task_manager.tasks.each do |task|

        get "/#{task.name}" do
          @tasks, @task = task_manager.tasks, task
          haml :task
        end

        post "/#{task.name}" do
          @tasks, @task = task_manager.tasks, task
          @result = task_manager.run task.name
          haml :result
        end
      end
    end
    app
  end

end
