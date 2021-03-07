class ProductsController < ApplicationController

    get '/products' do
        redirect_if_not_logged_in
        @products = @user.products
        erb :'/product/index'
    end

    get '/products/new' do 
        redirect_if_not_logged_in
        erb :'/product/new'
    end

    post '/products' do 
        redirect_if_not_logged_in
        p = params[:product]
        product = Product.new(name: p[:name], sku: p[:sku], description: p[:description], color: p[:color], company: p[:company])
        if product.save
            if !!p[:item_requirements]
                p[:item_requirements].each do |i|
                    ir = ItemRequirement.new()
                    ir.name = i[:name]
                    ir.length = i[:length]
                    ir.description = i[:description]
                    ir.unique = (i[:unique] == "on")
                    ir.length_required = (i[:length_required] == "on")
                    ir.save
                    product.item_requirements << ir
                end
            end
            @user.products << product
            flash[:notice] = ["Product Added"]
            redirect '/products'
        else
            flash[:error] = ["Could not add Product"]
            redirect '/products/new'
        end 
    end

    get '/products/:id/edit' do 
        redirect_if_not_logged_in
        @product = Product.find_by(id: params[:id])
        check_owner(@product, '/products')
        erb :'/product/edit'
    end

    get '/products/:id' do 
        redirect_if_not_logged_in
        @product = Product.find_by(id: params[:id])
        check_owner(@product, '/products')
        erb :'product/show'
    end

    patch '/products/:id' do 
        redirect_if_not_logged_in
        p = params[:product]
        product = Product.find_by(id: params[:id])
        check_owner(product, '/products')
        product.update(name: p[:name], sku: p[:sku], description: p[:description], color: p[:color], company: p[:company])
        if !!p[:item_requirements]
            p[:item_requirements].each do |i|
                ir = ItemRequirement.find_by(id: i[:id])
                ir = ItemRequirement.new if !ir 
                ir.name = i[:name]
                ir.length = i[:length]
                ir.description = i[:description]
                ir.unique = (i[:unique] == "on" || i[:unique] == "true")
                ir.length_required = (i[:length_required] == "on" || i[:length_required] == "true")
                ir.save
                product.item_requirements << ir
            end
        end
        flash[:notice] = ["Product Updated"]
        redirect "/products/#{product.id}"
    end

    delete '/products/:id' do
        redirect_if_not_logged_in
        product = Product.find_by(id: params[:id])
        check_owner(product, '/products')
        product.delete 
        flash[:notice] = ["Produced Deleted"]
        redirect '/products'
    end
end