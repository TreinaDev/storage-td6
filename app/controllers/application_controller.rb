class ApplicationController < ActionController::Base
  rescue_from MustBeAValidCsv, with: :redirect_to_new_csv_invalid
  rescue_from FileMustBeUploaded, with: :redirect_to_new_file_not_uploaded

  def redirect_to_new_file_not_uploaded
    redirect_to new_product_entry_path, notice: t('.file_must_be_uploaded')
  end

  def redirect_to_new_csv_invalid
    redirect_to new_product_entry_path, notice: t('.csv_must_be_valid')
  end
end
