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

    
    post '/login' do
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect "/account"
        else
          user = nil
          redirect '/'
        end
      end
  
      post '/signup' do
        if params[:password] == params[:confirm_password]
          user = User.new(email: params[:email], password: params[:password])
  
          if user.save
            session[:user_id] = user.id
            flash[:message] = "Successfully Logged In"
            redirect "/account"
          else
            user = nil
            redirect '/'
          end
        else
          user = nil
          redirect '/'
        end
      end
  
      get '/account/logout' do 
        session.clear
        erb :main
      end
end