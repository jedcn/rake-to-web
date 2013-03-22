desc 'rake to-web'
task 'to-web' do
  require 'sinatra/base'
  tasks = Rake.application.tasks

  project_root = File.expand_path File.join(__FILE__, '..', '..')
  project_views = File.join project_root, 'views'

  def execute_task(task)
    require 'ostruct'
    output = `rake #{task.name}`
    result = {
      :output => output,
      :status => $?
    }
    OpenStruct.new result
  end

  my_app = Sinatra.new do

    set :bind, 'localhost'

    set :haml, :format => :html5

    set :views, project_views

    get('/') do
      @tasks = tasks
      haml :task_index
    end

    tasks.each do |task|

      get "/#{task.name}" do
        @tasks, @task = tasks, task
        haml :task
      end

      post "/#{task.name}" do
        @tasks, @task = tasks, task
        @result = execute_task @task
        haml :task_result
      end
    end
  end

  my_app.run!
end
