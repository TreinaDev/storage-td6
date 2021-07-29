class DispatchLogsController < AuthenticationController
  before_action :set_item, only: %i[new create]

  def new
    @dispatch_log = DispatchLog.new
  end

  def create
    @dispatch_log = DispatchLog.new(**dispatch_log_params, item: @item, user: current_user)
    if @dispatch_log.save
      redirect_to @dispatch_log
    else
      render :new
    end
  end

  def show
    @dispatch_log = DispatchLog.find(params[:id])
  end

  private

  def dispatch_log_params
    params.require(:dispatch_log).permit(:item, :authorized_person)
  end

  def set_item
    @item = Item.find_by(code: params[:item_code])
  end
end
