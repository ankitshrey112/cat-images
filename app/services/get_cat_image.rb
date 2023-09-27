class GetCatImage < ActiveInteraction::Base
  integer :id
  integer :performed_by_user_id

  def execute
    cat_image = get_cat_image

    unless cat_image.present?
      raise CustomError.new('Resource Not Found', APIStatus::NOT_FOUND)
    end

    data = get_data(cat_image)

    return {
      data: data,
      status: APIStatus::OK
    }
  end

  def get_cat_image
    CatImage.where(status: CatImageStatus::ACTIVE).where("id = ?", self.id).first
  end

  def get_data(cat_image)
    {
      id: cat_image.id,
      name: cat_image.name,
      age: cat_image.age,
      breed: cat_image.breed,
      image_url: cat_image.get_image_url,
      created_at: cat_image.created_at,
      created_by_user: User.where(id: cat_image.created_by_user_id).first.email
    }
  end
end
