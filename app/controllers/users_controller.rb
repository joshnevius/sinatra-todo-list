class UsersController < ApplicationController

  get '/signup' do
    if !session[:user_id]
      erb :'/users/create_user'
    else
      redirect to '/lists'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty?
      redirect to '/signup'
    else 
      @user = User.new(username: params[:username], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/lists"
    end
  end

  get '/login' do
    if !session[:user_id]
      redirect '/lists'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/lists"
    else
      redirect "/signup"
    end
  end



end