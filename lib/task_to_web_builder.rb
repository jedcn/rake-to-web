require 'sinatra/base'
require 'json'

class TaskToWebBuilder

  def initialize(task_manager)
    @task_manager = task_manager
  end

  def app
    task_manager = @task_manager
    app = Sinatra.new do
      tasks = []
      task_manager.names.each do |name|
        tasks << OpenStruct.new({ :name => name })
      end

      set :bind, 'localhost'

      set :haml, :format => :html5

      lib = File.dirname __FILE__
      set :views, File.join(lib, 'app', 'views')

      get('/') do
        @tasks = tasks
        haml :index
      end

      tasks.each do |task|

        get "/#{task.name}" do
          @tasks, @task = tasks, task
          haml :task
        end

        post "/#{task.name}.?:format?" do
          @tasks, @task = tasks, task
          @result = task_manager.run task.name
          types = %w[text/html application/json]
          if params[:format] == 'json' || request.preferred_type(types) == 'application/json'
            content_type :json
            JSON.generate({ :result => @result })
          else
            haml :result
          end
        end
      end
    end
    app
  end

end
