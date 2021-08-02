class ReservedItemsController < ApplicationController
  def index
    @items = Item.reserveds.where(warehouse: current_user.my_warehouse)
  end
end
