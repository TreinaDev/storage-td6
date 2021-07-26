class ReservedItemsController < ApplicationController
  def index
    @items = Item.reserveds
  end

  def dispatch_item
    DispatchLog.dispatch_item(dispatch_params)
  end

  private

  def dispatch_params
    params.require(:dispatch).permit(:user, :authorized_person, :item)
  end
end