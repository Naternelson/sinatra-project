class UsersController < ApplicationController

    get '/products' do
        if session[:user_id]
            user = User.find_by(id: session[:user_id])
            @products = user.products
            erb :'/product/index'
        else
            redirect '/'
        end
    end

    get '/products/new' do 
        if session[:user_id]
            erb :'/product/new'
        else
            redirect '/'
        end
    end
end