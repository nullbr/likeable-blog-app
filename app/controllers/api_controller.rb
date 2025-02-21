# frozen_string_literal: true

class ApiController < ActionController::API
  def render_errors(messages, status = :unprocessable_entity)
    render json: { errors: messages }, status:
  end

  def render_record_not_found(record)
    return if record.present?

    render_errors([t("errors.not_found")], :not_found)
  end
end
