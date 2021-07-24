class SupplierIsActiveValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, I18n.t('.must_be_active') unless value&.active?
  end
end
