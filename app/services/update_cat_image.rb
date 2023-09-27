class UpdateCatImage < ActiveInteraction::Base
  integer :id
  string :name, default: nil
  integer :age, default: nil
  string :breed, default: nil
  object :image, class: CatImageFile::OBJECT_TYPE, default: nil

  def execute
    cat_image = get_cat_image

    unless cat_image.present?
      raise CustomError.new('Resource Not Found', :not_found)
    end

    unless cat_image.update(get_update_params)
      raise CustomError.new(cat_image.errors.full_messages.join(','), :bad_request)
    end

    return {
      id: cat_image.id
    }
  end

  def get_cat_image
    CatImage.where(status: CatImageStatus::ACTIVE).where("id = ?", self.id).first
  end

  def get_update_params
    @_interaction_inputs.except(:id).select {|k,v| v.present?}
  end
end
