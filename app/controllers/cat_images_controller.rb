class CatImagesController < ApplicationController
  before_action :authenticate_user!

  skip_before_action :verify_authenticity_token

  def health
    render json: { status: 'OK' }, status: APIStatus::OK
  end

  def create_cat_image
    get_service_respone(__method__.to_s)
  end

  def update_cat_image
    get_service_respone(__method__.to_s)
  end

  def list_cat_images
    get_service_respone(__method__.to_s)
  end

  def delete_cat_image
    get_service_respone(__method__.to_s)
  end

  def get_cat_image
    get_service_respone(__method__.to_s)
  end

  private

  # Do not change below method, just add new controllers above and implement new interaction in services with same name.
  def get_service_respone(request)
    interaction = request.camelize.constantize
    @required_params = interaction.new.inputs.keys.map(&:to_sym)

    begin
      params = self.permitted_params.merge({ performed_by_user_id: current_user.id })
      api_request = interaction.run(params)

      if api_request.valid?
        render json: api_request.result.except(:status), status: api_request.result[:status]
      else
        render json: api_request.errors.full_messages, status: APIStatus::BAD_REQUEST
      end
    rescue CustomError => e
      render json: { error: e.message }, status: e.status
    end
  end

  def permitted_params
    params.permit(@required_params)
  end
end
