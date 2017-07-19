require 'rack-flash'

class ClientController < ApplicationController
  use Rack::Flash

  get "/clients/signup" do
    erb :'clients/signup'
  end

  post "/clients/signup" do
    @client = Client.new(name: params[:name], email: params[:email], tel_nbr: params[:tel_nbr], address_1: params[:address_1], address_2: params[:address_2], city: params[:city], zipcode: params[:zipcode], state: params[:state], password: params[:password], shopper_id: params[:shopper_id])
    if @client.errors.messages.empty?
      @client.save
      session[:id] = @client.id
      redirect "/clients/#{@client.id}"
      flash[:message] = "You successfully created your brand new client account!"
    else
      flash[:message] = error_parser(@client.errors.messages.first)
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
      flash[:message] = "Something went wrong with the username or password. Please try again."
      redirect to "/clients/login"
    end
  end

  get "/clients/logout" do
    redirect to "/clients/login" unless logged_in?
    flash[:message] = "Successfully logged out."
    session.clear
    redirect to "/clients/login"
  end

  get "/clients" do
    redirect to "/clients/login" unless logged_in?
    @clients = Client.all
    erb :"clients/index"
  end

  get '/clients/:id' do
    redirect to "/clients/login" unless logged_in?
    @client = Client.find_by_id(params[:id])
    erb :"clients/show"
  end

  get "/clients/:id/edit" do
    redirect to "/clients/login" unless logged_in?
    @client = Client.find(params[:id])
    erb :"/clients/edit"
  end

  patch "/clients/:id" do
    @client = Client.find(params[:id])
    @client.update(name: params[:name],  email: params[:email], tel_nbr: params[:tel_nbr], address_1: params[:address_1], address_2: params[:address_2], city: params[:city], zipcode: params[:zipcode], state: params[:state], password: params[:password], shopper_id: params[:shopper_id])

    flash[:message] = "Client successfully updated!"
    redirect to "/clients/#{@client.id}"
  end

  delete '/clients/:id/delete' do
    redirect to "/clients/login" unless logged_in?
    @client = Client.find(params[:id])
    redirect to "/clients" unless current_client == @client
    @client.delete
    session.clear
    flash[:message] = "Client successfully deleted!"
    redirect to "/clients/signup"
  end


end
