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
      redirect "/lists/#{@list.id}/edit?error=invalid list"
    end
    @list.update(params.select{|k|k== "name"})
    redirect "/lists/#{@list.id}"
  end

  get "/lists/:id" do
    redirect_if_not_logged_in
    @list = List.find(params[:id])
    erb :'lists/show'
  end

  post "/lists" do
    redirect_if_not_logged_in
    unless List.valid_params?(params)
      redirect "/lists/new?error=invalid list"
    end
    List.create(params)
    redirect '/lists'
  end


end