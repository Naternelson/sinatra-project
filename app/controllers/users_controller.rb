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
      flash[:success] = ["Successfully Logged In!"]
      redirect "/account"
    else
      flash[:error] = ["Please check email and password"]
      redirect_if_not_logged_in
    end
  end

  post '/signup' do
    if params[:password] == params[:confirm_password]
      user = User.new(email: params[:email], password: params[:password])
      if user.save
        session[:user_id] = user.id
        flash[:success] = ["Successfully Signed up!"]
        redirect "/account"
      else
        flash[:error] = ["Email is already taken, or mistyped"]
        redirect_if_not_logged_in
      end
    else
      flash[:error] = ["Passwords do not match"]
      redirect_if_not_logged_in
    end
  end

  get '/account/logout' do 
    session.clear
    flash[:notice] = ["Successfully Logged Off"]
    redirect '/'
  end

  helpers do 
    def full_name
      name = "#{current_user.first_name} #{current_user.last_name}"
      if !name
        "No Name Yet"
      else 
        name
      end
    end
  end
end