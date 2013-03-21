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
      haml :index, :locals => { :tasks => tasks }
    end
  end

  my_app.run!
end
