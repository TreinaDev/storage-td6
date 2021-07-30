class ReturnEntriesController < AuthenticationController
  def index
    @warehouse = current_user.warehouse
    @return_entries = @warehouse.return_entries
  end

  def show
    @return_entry = ReturnEntry.find(params[:id])
  end
end
