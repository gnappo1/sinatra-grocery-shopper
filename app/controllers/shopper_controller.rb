require 'rack-flash'

class ShopperController < ApplicationController
  use Rack::Flash

  get "/shoppers/signup" do
    erb :'shoppers/signup'
  end

  post "/shoppers/signup" do
    @shopper = Shopper.new(name: params[:name], email: params[:email], tel_nbr: params[:tel_nbr], price_per_bag: params[:price_per_bag], neighborhood: params[:neighborhood], city: params[:city], state: params[:state], password: params[:password])
    if @shopper.save
      session[:shopper_id] = @shopper.id
      redirect "/shoppers/#{@shopper.id}"
      flash[:message] = "You successfully created your brand New Shopper Account!"
    else
      flash[:message] = error_parser(@shopper.errors.messages.first)
      redirect to "/shoppers/signup"
    end
  end

  get "/shoppers/login" do
    erb :"shoppers/login"
  end

  post "/shoppers/login" do
    @shopper = Shopper.find_by_name(params[:name])
    if @shopper && @shopper.authenticate(params[:password])
      session[:id] = @shopper.id
      redirect to "/shoppers/#{@shopper.id}"
    else
      flash[:message] = "Something went wrong with the username or password. Please try again."
      redirect to "/shoppers/login"
    end
  end

  get "/shoppers/logout" do
    authenticate_user
    session.clear
    flash[:message] = "Successfully logged out."
    redirect to "/"
  end

  get "/shoppers" do
    authenticate_user
    @shoppers = Shopper.all
    erb :"shoppers/index"
  end

  get '/shoppers/:id' do
    authenticate_user
    @shopper = Shopper.find_by_id(params[:id])
    erb :"shoppers/show"
  end

  get "/shoppers/:id/edit" do
    authenticate_user
    @shopper = Shopper.find(params[:id])
    erb :"shoppers/edit"
  end

  patch "/shoppers/:id" do
    @shopper = Shopper.find(params[:id])
    if @shopper.update(name: params[:name], tel_nbr: params[:tel_nbr], neighborhood: params[:neighborhood], city: params[:city], state: params[:state], price_per_bag: params[:price_per_bag], email: params[:email], password: params[:password])
      flash[:message] = "Shopper successfully updated!"
      redirect to "/shoppers/#{@shopper.id}"
    else
      flash[:message] = @shopper.errors.full_messages.join(', ')
      erb :"/shoppers/edit"
    end
  end

  delete '/shoppers/:id/delete' do
    authenticate_user
    @shopper = Shopper.find(params[:id])
    if @shopper && current_shopper == @shopper && @shopper.delete
      session.clear
      flash[:message] = "Shopper successfully deleted!"
      redirect to "/"
    else
      redirect to "/shoppers"
    end
  end
end
