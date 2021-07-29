class Api::V1::Freightage::ReturnEntriesController < ActionController::API
  def create
    @return_entry = ReturnEntry.new(return_params)
    if @return_entry.save
      render json: { return_entry: @return_entry.as_json(only: [:id]), 
                     message: I18n.t('return_entries.create.success') }, 
                     status: :created
    end
  end

  private

  def return_params
    params.require(:return_entry).permit(:request_number)
  end
end