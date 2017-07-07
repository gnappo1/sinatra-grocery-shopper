require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "secret"
  end

  get '/' do
    erb :welcome
  end

  helpers do
    def current_shopper
      @current_shopper ||= Shopper.find_by(id: session[:id])
    end

    def current_client
      @current_client ||= Client.find_by(id: session[:id])
    end

    def logged_in?
      !!session[:id]
    end

    def not_logged_in?
      if !logged_in?
        redirect('/')
      end
    end

    def error_parser(hash)
      "#{hash[0].to_s} #{hash[1][0]}"
    end
  end

end
