require 'rails_helper'

RSpec.describe DeleteCatImage do

  describe '#execute' do
    context 'with valid attributes' do
      cat_image = CatImage.create!({
        name: 'Fluffy',
        age: 2,
        breed: 'Persian',
        status: 'active',
        image: ActionDispatch::Http::UploadedFile.new(
            tempfile: Tempfile.new(['hello', '.png']),
            type: 'image/png',
            filename: 'original_file_name.png'
          )
      })

      it 'with a valid ID' do
        result = described_class.run({ id: cat_image.id })

        expect(result).to be_valid
        expect(result.result).to have_key(:id)

        cat_image.reload
        expect(cat_image.status).to eq('inactive')
      end
    end

    context 'returns an error' do
      it 'returns errors' do
        result = described_class.run({ id: -1 }) # Assuming -1 is an invalid ID

        expect(result).not_to be_valid
        expect(result.errors).not_to be_empty
        expect(result.errors.full_messages).to include('Resource not found')
      end
    end
  end
end
