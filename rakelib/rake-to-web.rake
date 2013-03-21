desc 'rake to-web'
task 'to-web' do
  require 'sinatra/base'
  tasks = Rake.application.tasks

  project_root = File.expand_path File.join(__FILE__, '..', '..')
  project_views = File.join project_root, 'views'

  def execute_task(task_name)
    `rake #{task_name}`
  end

  my_app = Sinatra.new do

    set :haml, :format => :html5

    set :views, project_views

    get('/') do
      haml :task_index, :locals => { :tasks => tasks }
    end

    tasks.each do |task|
      get "/#{task.name}" do
        haml :task, :locals => { :task => task }
      end

      post "/#{task.name}" do
        result = execute_task(task.name)
        haml :task_result, :locals => { :result => result, :task_name => task.name }
      end
    end
  end

  my_app.run!
end
