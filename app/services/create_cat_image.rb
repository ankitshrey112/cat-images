class CreateCatImage < ActiveInteraction::Base
  string :name, default: nil
  integer :age, default: nil
  string :breed, default: nil
  object :image, class: ActionDispatch::Http::UploadedFile

  def execute
    cat_image = CatImage.new(get_create_params)

    unless cat_image.save
      self.errors.merge!(cat_image.errors)
      return
    end

    return {
      id: cat_image.id
    }
  end

  def get_create_params
    @_interaction_inputs.merge(status: 'active')
  end
end
