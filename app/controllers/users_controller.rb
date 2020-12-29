class UsersController < ApplicationController

    get "/signup" do
        if !logged_in?
            erb :"users/signup"
        else
            redirect "/tweets"
        end
    end
    
    post "/signup" do
        if params.none? {|k,v| v.empty?}
            user = User.create(params)
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/signup"
        end
    end

    get "/login" do
        if !logged_in?
            erb :"users/login"
        else
            redirect "/tweets"
        end
    end

    post "/login" do
        user = User.find_by(username: params[:username])
        if !!user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/login"            
        end
    end

    get "/logout" do
        if logged_in?
            erb :"users/logout"
            redirect "/login"
        else
            redirect "/"
        end
    end

    post "/logout" do
        # binding.pry
        if params[:logout] == "Logout"
            session.clear
            redirect to "/login"
        elsif params[:tweets] == "Return to Tweets"
            redirect to "/tweets"
        elsif params[:login] == "Please Log In"
            redirect to "/login"
        else
            redirect to "/login"
        end
    end

    get "/users/:slug" do
        # binding.pry
            @user = User.find_by_slug(params[:slug])
            erb :"users/show"
    end
end
