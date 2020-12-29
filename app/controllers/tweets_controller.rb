class TweetsController < ApplicationController

    get "/tweets/new" do
        # binding.pry
        if logged_in?
            erb :"tweets/new"
        else
            redirect "/login"
        end
    end
    
    post "/tweets" do
        tweet = Tweet.create(params)
    end

    get "/tweets" do
        if logged_in?
            @tweets = Tweet.all
            erb :"tweets/index"
        else
            redirect "/login"
        end
    end

    get "/tweets/:id" do
        @tweet = Tweet.find_by(id: params[:id])
        if @tweet.user == current_user
            erb :"tweets/show"
        else
            redirect "/tweets"
        end
    end

    get "/tweets/:id/edit" do
        @tweet = Tweet.find_by(id: params[:id])
        erb :"tweets/edit"
    end

    patch "/tweets/:id" do
        tweet = Tweet.find_by(id: params[:id])
        tweet.update(params[:tweet])
    end

    delete "/tweets/:id/delete" do
        if !current_user.tweets.include?(@tweet)
            redirect "/login"
        else
            tweet = Tweet.find_by(id: params[:id])
            tweet.destroy
            redirect "/tweets"
        end
    end

end
