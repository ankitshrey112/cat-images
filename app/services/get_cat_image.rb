class GetCatImage < ActiveInteraction::Base
  integer :id

  def execute
    cat_image = get_cat_image

    unless cat_image.present?
      self.errors.add(:base, 'Resource not found')
      return
    end

    data = get_data(cat_image)

    return {
      data: data
    }
  end

  def get_cat_image
    CatImage.where(status: 'active').where("id = ?", self.id).first
  end

  def get_data(cat_image)
    {
      id: cat_image.id,
      name: cat_image.name,
      age: cat_image.age,
      breed: cat_image.breed,
      image_url: cat_image.get_image_url,
      created_at: cat_image.created_at
    }
  end
end
