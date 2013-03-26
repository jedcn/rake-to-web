require 'sinatra/base'
require 'json'

class TaskToWebBuilder

  def initialize(task_manager)
    @task_manager = task_manager
  end

  def app
    task_manager = @task_manager
    task_names = task_manager.names

    app = Sinatra.new do

      set :bind, 'localhost'

      set :haml, :format => :html5

      lib = File.dirname __FILE__
      set :views, File.join(lib, 'app', 'views')

      get('/') do
        @task_names = task_names
        haml :index
      end

      task_names.each do |task_name|

        get "/#{task_name}" do
          @task_names, @task_name = task_names, task_name
          haml :task
        end

        post "/#{task_name}.?:format?" do
          @task_names, @task_name = task_names, task_name
          @result = task_manager.run task_name
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
