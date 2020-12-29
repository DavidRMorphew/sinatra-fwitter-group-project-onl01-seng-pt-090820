require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "ainigma"
  end

  get "/" do
    erb :index
  end

  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			@current_user ||= User.find(session[:user_id])
    end
    #  authorized_to_edit?(child.id)
      #  redirect to an index
    # redirect_if_not_logged_in
      #  redirect to login page
  end
  
end
