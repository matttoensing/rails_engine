module Api
  module V1
    module Items
      class SearchController < ApplicationController
        def index
          item = Item.search_results(params[:name])
          if item.nil?
            render(json: items_error_message(params[:name]), status: 400)
          else
            render(json: ItemSerializer.new(item))
          end
        end
      end
    end
  end
end
