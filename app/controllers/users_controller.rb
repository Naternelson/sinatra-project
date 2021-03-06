class UsersController < ApplicationController

    get '/account' do
      redirect_if_not_logged_in
      erb :'/account/show'
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
          redirect_if_not_logged_in
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
            redirect_if_not_logged_in
          end
        else
          redirect_if_not_logged_in
        end
      end
  
      get '/account/logout' do 
        session.clear
        erb :main
      end
end