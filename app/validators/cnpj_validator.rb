class CnpjValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, I18n.t('.invalid_message') unless CNPJ.valid?(value, strict: true)
  end
end
