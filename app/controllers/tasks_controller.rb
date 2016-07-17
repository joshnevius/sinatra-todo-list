class TasksController < ApplicationController

  get '/tasks' do
    redirect_if_not_logged_in
    @user = current_user
    @lists = @user.lists
    erb :'/tasks/show'
  end

end