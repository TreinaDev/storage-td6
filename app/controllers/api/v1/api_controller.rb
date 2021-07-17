class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  private

  def record_invalid(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def not_found(exception)
    render json: { message: "#{model_name(exception.model)} não encontrado" }, status: :not_found
  end

  def parameter_missing
    render json:
                { errors:
                  'parece que você não enviou nenhum parametro ou o valor é vazio, preencha e envie novamente.' },
           status: :precondition_failed
  end

  def model_name(name)
    case name
    when 'Warehouse'
      'Galpão'
    when 'Product'
      'Produto'
    end
  end
end
