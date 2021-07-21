class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  private

  def record_invalid(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def not_found(exception)
    render json: { message: I18n.t('activerecord.errors.not_found',
                                   model_name: exception.model.constantize.model_name.human) },
           status: :not_found
  end

  def parameter_missing
    render json:
                { errors:
                  I18n.t('activerecord.errors.parameter_missing') },
           status: :precondition_failed
  end
end
