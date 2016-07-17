class UsersController < ApplicationController

  get '/signup' do
    if !session[:user_id]
      erb :'users/signup'
    else
      redirect to '/tasks'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty?
      redirect to '/signup'
    else 
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      redirect "/lists"
    end
  end

  get '/login' do
    if session[:user_id]
      redirect '/tasks'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tasks"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end


end