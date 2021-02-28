  
class ApplicationController < Sinatra::Base

    configure do
      set(:views, 'app/views')
      set :public_folder, 'public'
      enable :sessions
      set :session_secret, 'secret'
    end
  
    register Sinatra::Flash

    get '/' do
        "Welcome to My Sinatra App"
    end
end