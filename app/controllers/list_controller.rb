class ListsController < ApplicationController

  get '/lists' do
    redirect_if_not_logged_in
    @lists = List.all
    erb :'lists/index'
  end

  get '/lists/new' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'lists/new'
  end

  post '/lists/new' do 
    @user = current_user
    list = @user.lists.create(name: params[:name])
    task = list.tasks.create(name: params[:tasks][:name])
    redirect '/tasks'
  end

  get '/lists/:id/edit' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @list = List.find(params[:id])
    erb :'lists/edit'
  end

  post "/lists/:id" do
    redirect_if_not_logged_in
    @list = List.find(params[:id])
    
    unless List.valid_params?(params)
      redirect "/list?error=invalid list"
    end
    List.create(params)
    redirect '/lists'
  end


end