class Api::V1::Items::SearchController < ApplicationController
  def index
    if params[:name].blank?
      render json: { data: { message: 'NAME CANT BE BLANK' } }, status: :bad_request
    else
      items = Item.search(params[:name])
      render json: ItemSerializer.new(items), status: :ok
    end
  end
end
