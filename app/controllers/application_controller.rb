  
class ApplicationController < Sinatra::Base

    configure do
      set(:views, 'app/views')
      set :public_folder, 'public'
      enable :sessions
      set :session_secret, 'secret'
    end
  
    register Sinatra::Flash

    get '/' do
        erb :main
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
      binding.pry
      if params[:password] == params[:confirm_password]
        user = User.new(email: params[:email], password: params[:password])

        if user.save
          session[:user_id] = user.id
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

    get '/logout' do 
      session.clear
      erb :main
    end

    helpers do

      def current_user
        @user = User.find_by(id: session[:user_id])
      end
  
      def redirect_if_not_logged_in
          redirect '/' unless current_user
      end
    end
end