class ListController < ApplicationController

  get "/lists" do
    redirect to "/" unless logged_in?
    erb :"lists/index"
  end

  get "/lists/new" do
    redirect to "/" unless logged_in?
    erb :"lists/new"
  end

  post "/lists" do
    @list = List.create(name: params[:name], creation_date: params[:creation_date], items_quantities: params[:items_quantities], notes: params[:notes])
    @list.client_id = current_client.id
    @list.shopper_id = current_client.shopper.id
    @list.save ? (redirect to "/lists") : (redirect to "/lists/new")
  end

  get "/lists/:id" do
    redirect to "/" unless logged_in?
    @list = List.find_by_id(params[:id])
    erb :"lists/show"
  end

  get "/lists/:id/edit" do
    redirect to "/" unless logged_in?
    @list = List.find(params[:id])
    current_client && @list.client_id == current_client.id ? (erb :"lists/edit") : (redirect to "/lists")
  end

  patch "/lists/:id" do
    @list = List.find(params[:id])
    @list.update(name: params[:name], creation_date: params[:creation_date], items_quantities: params[:items_quantities], notes: params[:notes])
    redirect to "/lists/#{@list.id}"
  end

  delete '/lists/:id/delete' do
    redirect to "/" unless logged_in?
    @list = List.find(params[:id])
    if @list.client_id == current_client.id
      @list.delete
      redirect to "/lists"
    else
      redirect to "/lists"
    end
  end

end
