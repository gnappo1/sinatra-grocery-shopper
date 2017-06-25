class ShopperController < ApplicationController

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
      redirect to "/shoppers/login"
    end
  end

  get "/shoppers/logout" do
    redirect to "/shoppers/login" unless logged_in?
    session.clear
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
    @shopper.update(name: params[:name]) if !params[:name].empty?
    @shopper.update(tel_nbr: params[:tel_nbr]) if !params[:tel_nbr].empty?
    @shopper.update(location: params[:location]) if !params[:location].empty?
    @shopper.update(price_per_bag: params[:price_per_bag]) if !params[:price_per_bag].empty?
    @shopper.update(clients: params[:clients]) if !params[:clients].empty?
    @shopper.update(email: params[:email]) if !params[:email].empty?
    @shopper.update(password: params[:password]) if !params[:password].empty?
    redirect to "/shoppers/#{@shopper.id}"
  end

  delete '/shoppers/:id/delete' do
    redirect to "/shoppers/login" unless logged_in?
    @shopper = Shopper.find(params[:id])
    redirect to "/shoppers" unless current_shopper == @shopper
    @shopper.delete
    session.clear
    redirect to "/shoppers/signup"
  end

end
