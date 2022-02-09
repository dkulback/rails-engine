class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: :show
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    json_item_response(@item)
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
