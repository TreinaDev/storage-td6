class ReservedItemsController < ApplicationController
  def index
    @items = Item.reserveds.where(warehouse: current_user.warehouse)
  end
end
