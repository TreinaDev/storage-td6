class ReturnLogsController < AuthenticationController
  def new
    @return_log = ReturnLog.new
  end

  def create
    @return_entry = ReturnEntry.find(params[:return_entry_id])
    @return_log = @return_entry.return_logs.new(return_params)
    if @return_log.save
      redirect_to @return_entry
    else
      flash.now[:notice] = t('.fail')
      render :new
    end
  end

  private

  def return_params
    params.require(:return_log).permit(:date, :decision, :justification, :picture)
  end
end
