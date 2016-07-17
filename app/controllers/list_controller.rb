class ListsController < ApplicationController

  get '/lists' do
    redirect_if_not_logged_in
    @lists = List.all
    erb :'/lists/create_list'
  end

end