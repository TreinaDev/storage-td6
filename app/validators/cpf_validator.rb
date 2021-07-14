class CpfValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless CPF.valid?(value, strict: true)
      record.errors.add attribute, (options[:message] || "deve ser válido")
    end
  end
end