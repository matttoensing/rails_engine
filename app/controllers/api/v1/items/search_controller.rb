class Api::V1::Items::SearchController < ApplicationController
  MAX_MIN_PRICE = 10_000

  def index
    if name_is_missing? || no_params_given?
      json_response(ErrorMessage.wrong_item_params_error, :bad_request)

    elsif search_by_name_only?
      item = Item.search_results(params[:name])
      return json_response(ErrorMessage.items_error_message(params[:name]), 400) if item.nil?

      item = Item.search_results(params[:name])
      json_response(ItemSerializer.new(item))

    elsif searching_for_name_and_price_range?

      json_response(ErrorMessage.item_min_price_search_error, :bad_request)

    elsif min_price_out_of_bounds?
      json_response(ErrorMessage.item_min_price_too_big)

    elsif valid_min_and_max_price?
      return json_response(ErrorMessage.min_price_greater_than_max_price, :bad_request) if min_price_greater_than_max_price?

      item = Item.find_by_min_max_price(params[:min_price].to_i, params[:max_price].to_i)
      json_response(ItemSerializer.new(item))

    elsif missing_max_price?
      return json_response(ErrorMessage.item_min_price_search_error, :bad_request) if params[:min_price].to_i <= 0

      item = Item.find_by_min_price(params[:min_price].to_i)
      json_response(ItemSerializer.new(item))

    elsif missing_min_price?
      return json_response(ErrorMessage.item_min_price_search_error, :bad_request) if params[:max_price].to_i <= 0

      item = Item.find_by_max_price(params[:max_price].to_i)
      json_response(ItemSerializer.new(item))
    end
  end

  private

  def search_by_name_only?
    !params[:max_price].present? && !params[:min_price].present?
  end

  def searching_for_name_and_price_range?
    params[:name].present? && params[:min_price].present? || params[:name].present? && params[:max_price].present?
  end

  def min_price_out_of_bounds?
    params[:min_price].present? && params[:min_price].to_i > MAX_MIN_PRICE
  end

  def valid_min_and_max_price?
    params[:min_price].present? && params[:max_price].present?
  end

  def missing_max_price?
    params[:min_price].present? && !params[:max_price].present?
  end

  def missing_min_price?
    !params[:min_price].present? && params[:max_price].present?
  end

  def name_is_missing?
    params[:name].present? && params[:name] == ''
  end

  def no_params_given?
    !params[:name].present? && !params[:min_price].present? && !params[:max_price].present?
  end

  def min_price_greater_than_max_price?
    params[:min_price].to_i > params[:max_price].to_i
  end
end
