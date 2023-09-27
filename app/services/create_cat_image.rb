class CreateCatImage < ActiveInteraction::Base
  string :name, default: nil
  integer :age, default: nil
  string :breed, default: nil
  object :image, class: CatImageFile::OBJECT_TYPE
  integer :performed_by_user_id

  def execute
    cat_image = CatImage.new(get_create_params)

    unless cat_image.save
      raise CustomError.new(cat_image.errors.full_messages.join(','), APIStatus::BAD_REQUEST)
    end

    return {
      id: cat_image.id,
      status: APIStatus::CREATED
    }
  end

  def get_create_params
    @_interaction_inputs.except(:performed_by_user_id).merge({
      status: CatImageStatus::ACTIVE,
      created_by_user_id: self.performed_by_user_id
    })
  end
end
