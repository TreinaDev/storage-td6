class Api::V1::Freightage::ReturnEntriesController < Api::V1::ApiController
  def create
    @return_entry = ReturnEntry.new(return_params)
    return unless @return_entry.save

    render json: { return_entry: @return_entry.as_json(only: [:id]),
                   message: I18n.t('return_entries.create.success') },
           status: :created
  end

  private

  def return_params
    params.require(:return_entry).permit(:request_number)
  end
end
