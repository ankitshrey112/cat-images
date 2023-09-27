module CatImageStatus
  ACTIVE = 'active'.freeze
  INACTIVE = 'inactive'.freeze
end

module CatImageFile
  RESIZE = '400x300^'.freeze
  CROP = '400x300+0+0'.freeze
  OBJECT_TYPE = ActionDispatch::Http::UploadedFile
end

module ListAPI
  DEFAULT_PAGE = 1.freeze
  DEFAULT_PER_PAGE = 10.freeze
end

module APIStatus
  NOT_FOUND = :not_found.freeze
  BAD_REQUEST = :bad_request.freeze
  CREATED = :created.freeze
  OK = :ok.freeze
  FORBIDDEN = :forbidden.freeze
end
