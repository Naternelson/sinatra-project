  
class ApplicationController < Sinatra::Base

    configure do
      set(:views, 'app/views')
      set :public_folder, 'public'
      enable :sessions
      set :session_secret, 'secret'
    end
  
    register Sinatra::Flash

    get '/' do
        erb :main, layout: :'home-layout'
    end

    helpers do

      def current_user
        @user = User.find_by(id: session[:user_id])
      end
  
      def redirect_if_not_logged_in
          redirect '/' unless current_user
      end

      def check_owner(obj, page='/account/logout')
        redirect page unless check_owner_without_redirect(obj)
      end

      def check_owner_without_redirect(obj)
        obj.user == current_user
      end

      def user_orders
        @user.products.collect {|p| p.orders }.flatten.uniq
      end
      

    end
end