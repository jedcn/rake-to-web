require 'spec_helper'

describe TaskToWebBuilder do

  describe '.new' do
    it 'requires a task manager' do
      simple_task_manager = SimpleTaskManager.new
      TaskToWebBuilder.new simple_task_manager
    end
  end

  describe '.app returns an application where:' do

    include Rack::Test::Methods

    def app
      simple_task_manager = SimpleTaskManager.new
      builder = TaskToWebBuilder.new simple_task_manager
      builder.app
    end

    where 'GET "/" returns an index that contains links to tasks' do
      get '/'
      last_response.should be_ok
      last_response.body.should =~ /multiply_4_by_4/
      last_response.body.should =~ /add_4_and_4/
    end

    where 'GET "/task_name" returns a page with a form to execute the task' do
      get '/multiply_4_by_4'
      last_response.should be_ok
      last_response.should =~ /form action='\/multiply_4_by_4' method='POST'/

      get '/add_4_and_4'
      last_response.should be_ok
      last_response.should =~ /form action='\/add_4_and_4' method='POST'/
    end

    where 'POST "/task_name" executes the task and returns the result' do
      post '/multiply_4_by_4'
      last_response.should be_ok
      last_response.should =~ /16/

      post '/add_4_and_4'
      last_response.should be_ok
      last_response.should =~ /8/
    end

    where 'POST "/task_name.json" executes the task and returns the result as json' do
      require 'json'

      post '/multiply_4_by_4.json'
      last_response.should be_ok
      last_response.content_type.should =~ /application\/json/
      parsed = JSON.parse last_response.body
      parsed['result'].should == 16


      post '/add_4_and_4.json'
      last_response.should be_ok
      parsed = JSON.parse last_response.body
      parsed['result'].should == 8
    end

  end

end
