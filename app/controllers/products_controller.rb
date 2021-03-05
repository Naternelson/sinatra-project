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

    post '/products' do 
        if session[:user_id]
            p = params[:product]
            product = Product.new(name: p[:name], sku: p[:sku], description: p[:description], color: p[:color], company: p[:company])
            if product.save
                if !!p[:item_requirements]
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

    get '/products/:id/edit' do 
        if session[:user_id]
            @product = Product.find_by(id: params[:id])
            if @product.user.id == session[:user_id]
                erb :'/product/edit'
            else 
                @product = nil
                redirect '/products'
            end
        else
            redirect '/'
        end 
    end

    get '/products/:id' do 
        if session[:user_id] 
            if Product.find_by(id: params[:id]).user_id == session[:user_id]
                @product = Product.find_by(id: params[:id])
                erb :'product/show'
            else
                redirect '/products'
            end
        else
            redirect '/'
        end
    end

    patch '/products/:id' do 
        if session[:user_id]
            p = params[:product]
            product = Product.find_by(id: params[:id])
            if product && product.user.id == session[:user_id]
                product.update(name: p[:name], sku: p[:sku], description: p[:description], color: p[:color], company: p[:company])
                if !!p[:item_requirements]
                    p[:item_requirements].each do |i|
                    ir = ItemRequirement.find_by(id: i[:id])
                    ir = ItemRequirement.new if !ir 
                    ir.name = i[:name]
                    ir.length = i[:length]
                    ir.description = i[:description]
                    ir.required = (i[:required] == "on")
                    ir.length_required = (i[:length_required] == "on")
                    ir.save
                    product.item_requirements << ir
                    end
                end
                redirect "/products/#{product.id}"
            else
                redirect "/products"
            end
        else
            redirect '/'
        end  
    end

    delete '/products/:id' do
        if session[:user_id] 
            if Product.find_by(id: params[:id]).user_id == session[:user_id]
                product = Product.find_by(id: params[:id])
                product.delete if product
            end
            redirect '/products'
        else
            redirect '/'
        end
    end
end