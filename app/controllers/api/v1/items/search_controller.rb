class Api::V1::Items::SearchController < ApplicationController
  def index
    if params[:name].blank?
      render json: { data: { message: 'NAME CANT BE BLANK' } }, status: 404
    else
      items = Item.search(params[:name])
      render json: ItemSerializer.new(items)
    end
  end
end
