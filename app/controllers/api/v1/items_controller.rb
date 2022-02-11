class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: %i[show destroy update]
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.single_item(@item)
  end

  def create
    item = Item.create!(item_params)
    render json: ItemSerializer.single_item(item), status: :created
  end

  def destroy
    @item.destroy
    head :no_content
  end

  def update
    @item.update(item_params)
    if @item.save
      render json: ItemSerializer.single_item(@item)
    else
      render status: 404
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
