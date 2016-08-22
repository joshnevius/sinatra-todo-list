class ListsController < ApplicationController

# lists index
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

# edit lists
  get '/lists/:id/edit' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @list = List.find(params[:id])
    if @list.user != current_user
      redirect "/lists/new?error=this list does not belong to you!!"
    end
    erb :'lists/edit'
  end

  post "/lists/:id" do
    redirect_if_not_logged_in
    @list = List.find(params[:id])
    unless List.valid_params?(params)
      redirect "/lists/#{@list.id}/edit?error=invalid list"
    end
    @list.update(params.select{|k|k== "name"})
    redirect "/lists/#{@list.id}"
  end

# show a list
  get "/lists/:id" do
    redirect_if_not_logged_in
    @list = List.find(params[:id])
    if @list.user != current_user
      redirect "/lists/new?error=this list does not belong to you!!"
    else
      erb :'lists/show'
    end
  end

  post "/lists" do
    redirect_if_not_logged_in

    unless List.valid_params?(params)
      redirect "/lists/new?error=invalid list"
    end
    current_user.lists.create(params)
    redirect '/lists'
  end

# delete lists
  get '/lists/:id' do
    @list = List.find_by_id(params[:id])
    erb :'lists/edit'
  end

  delete '/lists/:id' do 
    @list = List.find_by_id(params[:id])
    @list.destroy
    redirect '/lists'
  end


end