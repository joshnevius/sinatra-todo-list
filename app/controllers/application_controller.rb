require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :session
    set :secret_session, 'secret_todo_list'
  end

  get '/' do
    erb :index
  end
  

end