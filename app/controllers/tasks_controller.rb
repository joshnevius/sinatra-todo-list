class TasksController < ApplicationController

  get '/tasks' do
    redirect_if_not_logged_in
    @tasks = Task.all
    erb :'tasks/index'
  end

  get '/tasks/new' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'tasks/new'
  end

  get '/tasks/:id/edit' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @task = Task.find(params[:id])
    erb :'tasks/edit'
  end

end