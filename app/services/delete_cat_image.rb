class DeleteCatImage < ActiveInteraction::Base
  integer :id

  def execute
    cat_image = get_cat_image

    unless cat_image.present?
      raise CustomError.new('Resource Not Found', :not_found)
    end

    unless cat_image.update(get_update_params)
      raise CustomError.new(cat_image.errors.full_messages.join(','), :bad_request)
    end

    return {
      id: cat_image.id,
      status: :ok
    }
  end

  def get_cat_image
    CatImage.where(status: CatImageStatus::ACTIVE).where("id = ?", self.id).first
  end

  def get_update_params
    {
      status: CatImageStatus::INACTIVE
    }
  end
end
