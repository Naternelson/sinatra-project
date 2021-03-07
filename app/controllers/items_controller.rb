class ItemsController < ApplicationController
    get '/orders/:id/items/new' do 
        verify_order
        erb :'item/new'
    end

    post '/orders/:id/items' do 
        verify_order
        item = Item.create()
        flash[:notice] = []
        params[:items].each do |code|
            code.each do |key, value|
                req = check_item_code(key)
                if req 
                    ic = ItemCode.create(code: value)
                    binding.pry
                    req.item_codes << ic
                    item.item_codes << ic
                    flash[:notice] << "#{value} Added"
                    binding.pry
                else
                    flash[:error] = ["Item Requirement Mismatch"]
                    redirect "/orders/#{@order.id}/items/new"
                end
            end
        end
        @order.items << item
        
    end


    helpers do 
        def input_pattern(req)
            binding.pry
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
    end
end