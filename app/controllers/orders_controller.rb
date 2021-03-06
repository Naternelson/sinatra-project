class OrdersController < ApplicationController

    get '/orders' do
        redirect_if_not_logged_in
        @orders = user_orders
        erb :'/order/index'
    end

    get '/orders/new' do 
        redirect_if_not_logged_in
        @products = @user.products 
        erb :'/order/new'
    end

    post '/orders' do 
        redirect_if_not_logged_in
        order = Order.create(order_params(params[:order]))
        order.status = 0
        add_product_to_order(params[:order][:product], order)
        flash[:notice] = ["Order Added"]
        redirect '/orders'
    end

    get '/orders/:id/edit' do 
        redirect_if_not_logged_in
        find_order
        check_owner(@order.product,'/orders')
        erb :'order/edit'
    end

    get '/orders/:id' do 
        redirect_if_not_logged_in
        find_order
        check_owner(@order.product,'/orders')
        erb :'order/show'
    end

    helpers do 
        def order_params(parameters)
            order_fields = [:order_num, :amount, :received_on, :due_by]
            parameters.select {|key, value| order_fields.include?(key.to_sym)}
        end

        def add_product_to_order(product_id, order_obj)
            product = Product.find_by(id: product_id)
            check_owner(product, '/orders/new')
            product.orders << order_obj
        end

        def order_status(order_obj)
            return "Not Started" if order_obj.status == 0
            return "Open" if order_obj.status == 1
            return "Complete" if order_obj.status == 2
            return "Paused" if order_obj.status == 3
            return "Error"
        end

        def date_format(date)
            if date.class.name == "Time"
                 date.strftime("%D")
            else
                "No date yet"
            end
        end

        def order_items
            data = []
            @order.items.each do |item|
                row = {}
                row[:id] = item.id
                order_item_header_ids.each do |id|
                    row[id] = item.item_codes.find {|ic| ic.item_requirement_id == id}
                end
                data << row
            end
            data
        end

        def order_item_headers
            @order.product.item_requirements.collect{|req| req.name}
        end

        def order_item_header_ids
            @order.product.item_requirements.collect{|req| req.id}
        end

        def add_list_item(item)
            item.item_codes.collect do |ic|
                "<li>#{ic.code}</li>"
            end
        end
    end
end