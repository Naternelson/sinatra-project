class ItemsController < ApplicationController
    get '/orders/:id/items/new' do 
        verify_order
        erb :'item/new'
    end

    post '/orders/:id/items' do 
        verify_order
        verify_completion
        item = Item.create()
        flash[:notice] = []
        flash[:error] = []
        params[:items].each do |code|
            code.each do |key, value|
                verify_code(key,value)
                ic = ItemCode.create(code: value) 
                @req.item_codes << ic
                item.item_codes << ic
                flash[:notice] << "#{value} Added" if flash[:notice]
                flash[:notice] = ["#{value} Added"] if !flash[:notice]
            end
        end
        @order.items << item
        verify_completion
        redirect "/orders/#{@order.id}/items/new"
    end


    helpers do 
        def input_pattern(req)
            if req.length_required
                "([a-zA-Z0-9]{#{req.length}})"
            else
                "([a-zA-Z0-9]+)"
            end
        end

        def verify_order 
            redirect_if_not_logged_in
            find_order
            check_owner_of_order
        end

        def check_item_code(id)
            verify_order
            ir = ItemRequirement.find_by(id: id)
            @order.product.item_requirements.include?(ir) ? ir : nil
        end

        def verify_unique(req, value)
            if req.unique
                if !!ItemCode.find_by(code: value)
                    flash[:error] << "#{value} already exists" if flash[:error]
                    flash[:error] = ["#{value} already exists"] if !flash[:error]
                    nil
                else
                    true
                end
            else
                true
            end
        end

        def verify_length(req, value)
            if req.length_required
                if value.length != req.length 
                    flash[:error] << "Value must be #{req.length} characters long" if flash[:error]
                    flash[:error] = ["Value must be #{req.length} characters long"] if !flash[:error]
                    nil
                else
                    true
                end
            else
                true
            end
        end

        def verify_code(key, value)
            @req = check_item_code(key)
            if @req 
                if !verify_unique(@req, value) || !verify_length(@req, value)
                    redirect "/orders/#{@order.id}/items/new"
                end
            else
                flash[:error] << ["Item Requirement Mismatch"]
                redirect "/orders/#{@order.id}/items/new"
            end
        end

        def verify_completion
            if @order.amount <= @order.items.count 
                flash[:success] = ["Order Complete!"]
                @order.status = 2
                redirect "/orders/#{@order.id}"
            end
        end
    end
end