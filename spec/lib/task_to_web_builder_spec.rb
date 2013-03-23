require 'spec_helper'

require 'rack/test'

describe TaskToWebBuilder do

  include Rack::Test::Methods

  describe '.app (when paired with a task manager)' do

    def app
      simple_task_manager = SimpleTaskManager.new
      builder = TaskToWebBuilder.new simple_task_manager
      builder.app
    end

    it 'GET "/" returns an index that contains links to the tasks from the task manager' do
      get '/'
      last_response.should be_ok
      last_response.body.should =~ /multiply_4_by_4/
      last_response.body.should =~ /add_4_and_4/
    end

    it 'GET "/task_name" exists for tasks from the task manager' do
      get '/multiply_4_by_4'
      last_response.should be_ok
      last_response.should =~ /form action='\/multiply_4_by_4' method='POST'/

      get '/add_4_and_4'
      last_response.should be_ok
      last_response.should =~ /form action='\/add_4_and_4' method='POST'/
    end

    it 'POST "/task_name" executes the task and returns the result' do
      post '/multiply_4_by_4'
      last_response.should be_ok
      last_response.should =~ /16/

      post '/add_4_and_4'
      last_response.should be_ok
      last_response.should =~ /8/
    end

  end

end
