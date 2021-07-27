class ReservedItemsController < ApplicationController
  def index
    @items = Item.reserveds.where(warehouse_id: current_user.warehouse_id)
  end
end
