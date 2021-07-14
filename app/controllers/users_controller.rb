class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
    @warehouses = Warehouse.all
  end

  def create
    
  end
end