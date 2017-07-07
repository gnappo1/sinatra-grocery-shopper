require 'rack-flash'

class ShopperController < ApplicationController
  use Rack::Flash

  get "/shoppers/signup" do
    erb :'shoppers/signup'
  end

  post "/shoppers/signup" do
    @shopper = Shopper.create(name: params[:name], email: params[:email], tel_nbr: params[:tel_nbr], price_per_bag: params[:price_per_bag], location: params[:location], password: params[:password])
    if @shopper.errors.empty?
      @shopper.save
      session[:id] = @shopper.id
      redirect "/shoppers/#{@shopper.id}"
    else
      flash[:error] = error_parser(@shopper.errors.messages.first)
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
    redirect to "/shoppers/login" unless logged_in?
    session.clear
    flash[:message] = "Successfully logged out."
    redirect to "/"
  end

  get "/shoppers" do
    redirect to "/shoppers/login" unless logged_in?
    @shoppers = Shopper.all
    erb :"shoppers/index"
  end

  get '/shoppers/:id' do
    redirect to "/shoppers/login" unless logged_in?
    @shopper = Shopper.find_by_id(params[:id])
    erb :"shoppers/show"
  end

  get "/shoppers/:id/edit" do
    redirect to "/shoppers/login" unless logged_in?
    @shopper = Shopper.find(params[:id])
    erb :"shoppers/edit"
  end

  patch "/shoppers/:id" do
    @shopper = Shopper.find(params[:id])
    @shopper.update(name: params[:name],tel_nbr: params[:tel_nbr], location: params[:location], price_per_bag: params[:price_per_bag], email: params[:email])
    flash[:message] = "Shopper successfully updated!"
    redirect to "/shoppers/#{@shopper.id}"
  end

  delete '/shoppers/:id/delete' do
    redirect to "/shoppers/login" unless logged_in?
    @shopper = Shopper.find(params[:id])
    redirect to "/shoppers" unless current_shopper == @shopper
    @shopper.delete
    session.clear
    flash[:message] = "Shopper successfully deleted!"
    redirect to "/shoppers/signup"
  end

end
