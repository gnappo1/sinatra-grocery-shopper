require 'rack-flash'

class ListController < ApplicationController
  use Rack::Flash

  get "/lists" do
    authenticate_user
    erb :"lists/index"
  end

  get "/lists/new" do
    authenticate_user
    erb :"lists/new"
  end

  post "/lists" do
    @list = current_client.lists.build(params[:list])
    @list.shopper_id = current_client.shopper.id
    if @list.save
      flash[:message] = "Successfully created a list!"
      redirect to "/lists"
    else
      flash[:message] = parse_error_message(@list.errors.messages.first)
      redirect to "/lists/new"
    end
  end

  get "/lists/:id" do
    authenticate_user
    @list = List.find_by_id(params[:id])
    erb :"lists/show"
  end

  get "/lists/:id/edit" do
    authenticate_user
    @list = List.find(params[:id])
    if @list && @list.client_id == current_client.id
      erb :"lists/edit"
    else
      redirect to "/lists"
    end
  end

  patch "/lists/:id" do
    @list = List.find(params[:id])
    if @list.update(name: params[:name], creation_date: params[:creation_date], items_quantities: params[:items_quantities], notes: params[:notes])
      flash[:message] = "Successfully updated the list!"
      redirect to "/lists/#{@list.id}"
    else
      flash[:message] = @list.errors.full_messages.join(',')
      erb :"lists/edit"
    end
  end

  delete '/lists/:id/delete' do
    authenticate_user
    @list = List.find(params[:id])
    if @list && @list.client_id == current_client.id && @list.delete
        redirect to "/lists"
        flash[:message] = "Successfully deleted the list!"
    else
      redirect to "/lists"
    end
  end

end
