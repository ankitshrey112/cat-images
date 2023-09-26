class DeleteCatImage < ActiveInteraction::Base
  integer :id

  def execute
    cat_image = get_cat_image

    unless cat_image.present?
      self.errors.add(:base, 'Resource not found')
      return
    end

    unless cat_image.update(get_update_params)
      self.errors.merge!(cat_image.errors)
      return
    end

    return {
      id: cat_image.id
    }
  end

  def get_cat_image
    CatImage.where("id = ?", self.id).first
  end

  def get_update_params
    {
      status: CatImageStatus::INACTIVE
    }
  end
end
