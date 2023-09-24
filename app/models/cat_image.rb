class CatImage < ApplicationRecord
  has_one_attached :image

  validate :validate_image

  before_create :rename_image

  def get_image_url
    Rails.application.routes.url_helpers.url_for(self.compressed_image)
  end

  def compressed_image
    image.variant(resize: "400x300^", crop: '400x300+0+0')
  end

  private

  def validate_image
    return if !new_record? && !image.attachment_changes['attachment'].present?

    unless self.image.attached?
      self.errors.add(:image, 'no image file found!')
      image.purge and return
    end

    unless self.image.blob.content_type.starts_with?('image/')
      self.errors.add(:image, 'invalid file type, please upload a valid image file')
      image.purge and return
    end

    if self.image.blob.byte_size > 10.megabytes
      self.errors.add(:image, 'image size cannot be greater than 10 megabytes')
      image.purge and return
    end
  end

  def rename_image
    original_filename = self.id.to_s
    timestamp = Time.now.to_i
    new_filename = "#{original_filename}_#{timestamp}"
    
    self.image.blob.update(filename: new_filename)
  end
end
