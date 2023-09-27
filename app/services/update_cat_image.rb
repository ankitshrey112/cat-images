class UpdateCatImage < ActiveInteraction::Base
  integer :id
  string :name, default: nil
  integer :age, default: nil
  string :breed, default: nil
  object :image, class: CatImageFile::OBJECT_TYPE, default: nil
  integer :performed_by_user_id

  def execute
    cat_image = get_cat_image

    unless cat_image.present?
      raise CustomError.new('Resource Not Found', APIStatus::NOT_FOUND)
    end

    unless cat_image.created_by_user_id.to_i == self.performed_by_user_id.to_i
      raise CustomError.new('Resource uploaded by different user cannot be updated', APIStatus::FORBIDDEN)
    end

    unless cat_image.update(get_update_params)
      raise CustomError.new(cat_image.errors.full_messages.join(','), APIStatus::BAD_REQUEST)
    end

    return {
      id: cat_image.id,
      status: APIStatus::OK
    }
  end

  def get_cat_image
    CatImage.where(status: CatImageStatus::ACTIVE).where("id = ?", self.id).first
  end

  def get_update_params
    @_interaction_inputs.except(:id, :performed_by_user_id).select {|k,v| v.present?}
  end
end
