class UsersController < ApplicationController

    get '/account' do
        if session[:user_id]
            @user = User.find_by(id: session[:user_id])
            erb :'/account/show'
        else
            redirect '/'
        end
    end

    get '/account/edit' do 
        erb :'/account/edit'
    end
end