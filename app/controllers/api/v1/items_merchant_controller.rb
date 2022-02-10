class Api::V1::ItemsMerchantController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    if @item
      json_response(@item.merchant)
    else
      json_response(@item)
    end
  end
end
