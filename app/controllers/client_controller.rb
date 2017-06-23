require './config/environment'

class ClientController < ApplicationController

  get "/clients/signup" do
    erb :'clients/signup'
  end

  post "/clients/signup" do
    @client = Client.create(name: params[:name], email: params[:email], tel_nbr: params[:tel_nbr], address: params[:address], password: params[:password], shopper_id: params[:shopper_id])
    if @client.errors.messages.empty?
      session[:id] = @client.id
      redirect "/clients/#{@client.id}"
    else
      redirect to "/clients/signup"
    end
  end

  get "/clients/login" do
    erb :"clients/login"
  end

  post "/clients/login" do
    @client = Client.find_by_name(params[:name])
    if @client && @client.authenticate(params[:password])
      session[:id] = @client.id
      redirect to "/clients/#{@client.id}"
    else
      redirect to "/clients/login"
    end
  end

  get "/clients/logout" do
    if logged_in?
      session.clear
      redirect to "/clients/login"
    else
      redirect to "/"
    end
  end

  get "/clients" do
    @clients = Client.all
    logged_in? ? (erb :"clients/index") : (erb :"clients/login")
  end

  get '/clients/:id' do
    @client = Client.find_by_id(params[:id])
    logged_in? ? (erb :"clients/show") : (erb :"clients/login")
  end

  get "/clients/:id/edit" do
    @client = Client.find(params[:id])
    erb :"/clients/edit"
  end

end
