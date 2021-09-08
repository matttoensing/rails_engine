class Api::V1::ItemsController < ApplicationController
  def index
    if params[:per_page].present? && !params[:page].present?
      items = Item.paginate(:page => nil, :per_page => params[:per_page])
      json_response(ItemSerializer.new(items))
    elsif params[:page].present? && params[:page].to_i <= 0
      items = Item.paginate(:page => 1, :per_page => 20)
      json_response(ItemSerializer.new(items))
    else
      items = Item.paginate(:page => params[:page], :per_page => 20)
      json_response(ItemSerializer.new(items))
    end
  end

  def show
    json_response(ItemSerializer.new(Item.find(params[:id])))
  end

  def create
    item = Item.create(item_params)
    if item.save
      json_response(ItemSerializer.new(item))
    else
      json_response(missing_attributes_error, 404)
    end
  end

  def update
    item = Item.find(params[:id])

    if params[:merchant_id].present?
      merchant = Merchant.find(params[:merchant_id])
      return json_response(items_update_error, status: 404) if merchant.nil?
      json_response(ItemSerializer.new(Item.update(params[:id], item_params)))
    elsif !params[:merchant_id].present?
      merchant = item.merchant
      return json_response(items_update_error, status: 404) if merchant.nil?
      json_response(ItemSerializer.new(Item.update(params[:id], item_params)))
    else
      json_response(ItemSerializer.new(Item.update(params[:id], item_params)))
    end
  end

  def destroy
    json_response(Item.destroy(params[:id]))
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
