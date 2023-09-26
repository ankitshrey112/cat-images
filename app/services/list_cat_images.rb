class ListCatImages < ActiveInteraction::Base
  integer :per_page, default: ListAPI::DEFAULT_PER_PAGE
  integer :page, default: ListAPI::DEFAULT_PAGE

  def execute
    query = get_query

    data = get_data(query)
    pagination_data = get_pagination_data(query)

    return {
      list: data
    }.merge!(pagination_data)
  end

  def get_query
    CatImage.where(status: CatImageStatus::ACTIVE).order(created_at: :desc).page(self.page).per(self.per_page)
  end

  def get_pagination_data(query)
    {
      current_page: self.page,
      current_count: self.per_page,
      total_pages: query.total_pages,
      total_count: query.total_count,
    }
  end

  def get_data(query)
    list = query.map do |object|
      {
        id: object.id,
        name: object.name,
        age: object.age,
        breed: object.breed,
        image_url: object.get_image_url,
        created_at: object.created_at
      }
    end

    list
  end
end
