class Api::V1::Items::SearchController < ApplicationController
  def index
    if !params[:max_price].present? && !params[:min_price].present?
      item = Item.search_results(params[:name])
      return json_response(ItemSerializer.items_error_message(params[:name]), 400) if item.nil?

      item = Item.search_results(params[:name])
      json_response(ItemSerializer.new(item))

    else

      if params[:name].present? && params[:min_price].present?
        json_response(ItemSerializer.item_min_price_search_error, 400)

      elsif params[:name].present? && params[:max_price].present?
        json_response(ItemSerializer.item_min_price_search_error, 400)

      elsif params[:min_price].present? && params[:min_price].to_i > 10000
        json_response(ItemSerializer.item_min_price_too_big)

      elsif params[:min_price].present? && params[:max_price].present?
        item = Item.find_by_min_max_price(params[:min_price].to_i, params[:max_price].to_i)
        json_response(ItemSerializer.new(item))

      elsif params[:min_price].present? && !params[:max_price].present?
        return json_response(ItemSerializer.item_min_price_search_error, 400) if params[:min_price].to_i <= 0

        item = Item.find_by_min_price(params[:min_price].to_i)
        json_response(ItemSerializer.new(item))

      elsif !params[:min_price].present? && params[:max_price].present?
        return json_response(ItemSerializer.item_min_price_search_error, 400) if params[:max_price].to_i <= 0

        item = Item.find_by_max_price(params[:max_price].to_i)
        json_response(ItemSerializer.new(item))
      end
    end
  end
end
