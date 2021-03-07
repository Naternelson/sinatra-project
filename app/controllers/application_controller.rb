  
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
        if !current_user
          flash[:notice] = "Please log in"
          redirect '/' 
        end
      end

      def check_owner(obj, page='/account/logout')
        if !check_owner_without_redirect(obj)
          flash[:error] = "Restricted #{split_class_name(obj)}"
          redirect page
        end
      end

      def split_class_name(obj)
        obj.class.name.split(/([A-Z][a-z]*)/).reject{ |e| e.to_s.empty? }.join(" ")
      end

      def check_owner_without_redirect(obj)
        obj.user == current_user
      end

      def user_orders
        @user.products.collect {|p| p.orders }.flatten.uniq
      end
      

    end
end