desc 'rake to-web'
task 'to-web' do
  require 'sinatra/base'
  tasks = Rake.application.tasks

  project_root = File.expand_path File.join(__FILE__, '..', '..')
  project_views = File.join project_root, 'views'

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
    end
  end

  my_app.run!
end
