class ListCatImages < ActiveInteraction::Base
  integer :per_page, default: ListAPI::DEFAULT_PER_PAGE
  integer :page, default: ListAPI::DEFAULT_PAGE
  integer :performed_by_user_id

  def execute
    query = get_query

    data = get_data(query)
    pagination_data = get_pagination_data(query)

    add_uploaded_by_user_data(data)

    return {
      list: data,
      status: APIStatus::OK
    }.merge!(pagination_data)
  end

  def get_query
    CatImage.where(status: CatImageStatus::ACTIVE).order(created_at: :desc).page(self.page).per(self.per_page)
  end

  def get_pagination_data(query)
    {
      current_page: self.page,
      current_count: query.count,
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
        created_at: object.created_at,
        created_by_user_id: object.created_by_user_id
      }
    end

    list
  end

  def add_uploaded_by_user_data(data)
    user_ids = data.pluck(:created_by_user_id)

    users = User.where(id: user_ids).as_json.map(&:deep_symbolize_keys)
    users_map = users.inject({}) {|h,v| h[v[:id]] = v[:email]; h}

    data = data.map do |object|
      object[:created_by_user] = users_map[object[:created_by_user_id]]
      object.delete(:created_by_user_id)

      object
    end

    return data
  end
end
