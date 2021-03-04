class UsersController < ApplicationController

    get '/products' do
        if session[:user_id]
            user = User.find_by(id: session[:user_id])
            @products = user.products
            binding.pry
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

    post '/products' do 
        if session[:user_id]
            p = params[:product]
            product = Product.new(name: p[:name], sku: p[:sku], description: p[:description], color: p[:color], company: p[:company])
            if product.save
                p[:item_requirements].each do |i|
                    ir = ItemRequirement.new()
                    ir.name = i[:name]
                    ir.length = i[:length]
                    ir.description = i[:description]
                    ir.required = (i[:required] == "on")
                    ir.length_required = (i[:length_required] == "on")
                    ir.save
                    product.item_requirements << ir
                end
                user = User.find_by(id: session[:user_id])
                user.products << product
                redirect '/products'
            else 
                redirect '/products/new'
            end 
        else
            redirect '/'
        end
    end
end