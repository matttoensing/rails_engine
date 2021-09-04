module Api
  module V1
    module Items
      class SearchController < ApplicationController
        def index
          item = Item.search_results(params[:query])
          render(json: ItemSerializer.new(item))
        end
      end
    end
  end
end
