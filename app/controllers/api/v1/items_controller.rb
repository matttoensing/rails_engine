class Api::V1::ItemsController < ApplicationController
  def index
    if per_page_present_only?
      items = Item.paginate(page: nil, per_page: params[:per_page])
      json_response(ItemSerializer.new(items))
    elsif page_less_than_zero?
      items = Item.paginate(page: 1, per_page: 20)
      json_response(ItemSerializer.new(items))
    else
      items = Item.paginate(page: params[:page], per_page: 20)
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
      json_response(ErrorMessage.missing_attributes_error, :not_found)
    end
  end

  def update
    item = Item.find(params[:id])
    if params[:merchant_id].present?
      merchant = Merchant.find(params[:merchant_id])
      json_response(ItemSerializer.new(Item.update(params[:id], item_params)))
    else
      json_response(ItemSerializer.new(Item.update(params[:id], item_params)))
    end
  end

  def destroy
    json_response(Item.destroy(params[:id]), :no_content)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

  def per_page_present_only?
    params[:per_page].present? && !params[:page].present?
  end

  def page_less_than_zero?
    params[:page].to_i <= 0
  end
end
