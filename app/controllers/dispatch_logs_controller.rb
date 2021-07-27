class DispatchLogsController < AuthenticationController
  def new
    @item = Item.find(params[:item])
    @dispatch_log = DispatchLog.new
  end

  def create
    @item = Item.find_by(code: params[:item][:code])
    @dispatch_log = DispatchLog.new(dispatch_log_params.merge(item: @item))
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
    params.require(:dispatch_log).permit(:item, :authorized_person).merge(user: current_user)
  end
end
