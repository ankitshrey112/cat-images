class CatImagesController < ApplicationController
  SUCCESS = 'OK'
  BAD_REQUEST = '400 Bad Request'

  http_basic_authenticate_with name: "ankit", password: "12345"

  protect_from_forgery with: :null_session

  def health
    render json: { status: SUCCESS }, status: :ok
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

    api_request = interaction.run(self.permitted_params)

    if api_request.errors.present?
      render json: { status: BAD_REQUEST, messages: api_request.errors.full_messages }, status: :bad_request
    else
      render json: api_request.result, status: :ok
    end
  end

  def permitted_params
    params.permit(@required_params)
  end
end
