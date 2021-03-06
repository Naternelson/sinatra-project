class OrdersController < ApplicationController

    get '/orders' do
        redirect_if_not_logged_in
        @orders = @user.orders
        erb :'/order/index'
    end

    get '/orders/new' do 
        redirect_if_not_logged_in
        @products = @user.products 
        erb :'/order/new'
    end

    post '/orders' do 
        redirect_if_not_logged_in
        binding.pry
    end
end