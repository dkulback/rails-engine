class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: %i[show destroy update]
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    json_item_response(@item)
  end

  def create
    item = Item.create!(item_params)
    json_item_response(item, :created)
  end

  def destroy
    @item.destroy
    head :no_content
  end

  def update
    @item.update(item_params)
    if @item.save
      json_item_response(@item)
    else
      render status: 404
    end
  end

  def find
    if params[:name].blank?
      render json: { data: { message: 'NAME CANT BE BLANK' } }, status: 404
    else
      items = Item.search(params[:name])
      render json: ItemSerializer.new(items)
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.permit(:name, :unit_price, :description, :merchant_id)
  end
end
