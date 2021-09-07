class Api::V1::ItemsController < ApplicationController
  def index
    if params[:per_page].present? && !params[:page].present?
      items = Item.paginate(:page => nil, :per_page => params[:per_page])
      render(json: ItemSerializer.new(items))
    elsif params[:page].present? && params[:page].to_i <= 0
      items = Item.paginate(:page => 1, :per_page => 20)
      render(json: ItemSerializer.new(items))
    else
      items = Item.paginate(:page => params[:page], :per_page => 20)
      render(json: ItemSerializer.new(items))
    end
  end

  def show
    render(json: ItemSerializer.new(Item.find(params[:id])))
  end

  def create
    item = Item.create(item_params)
    if item.save
      render(json: ItemSerializer.new(Item.create(item_params)))
    else
      json_response(missing_attributes_error, 404)
    end
  end

  def update
    item = Item.find(params[:id])

    if params[:merchant_id].present?
      merchant = Merchant.find(params[:merchant_id])
      return render(json: items_update_error, status: 404) if merchant.nil?
      render(json: ItemSerializer.new(Item.update(params[:id], item_params)))
    elsif !params[:merchant_id].present?
      merchant = item.merchant
      return render(json: items_update_error, status: 404) if merchant.nil?
      render(json: ItemSerializer.new(Item.update(params[:id], item_params)))
    else
      render(json: ItemSerializer.new(Item.update(params[:id], item_params)))
    end
  end

  def destroy
    render(json: Item.destroy(params[:id]))
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
