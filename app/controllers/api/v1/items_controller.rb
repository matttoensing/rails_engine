class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.paginate(:page => params[:page], :per_page => 20)
    render(json: ItemSerializer.new(items))
  end
end
