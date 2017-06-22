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

end
