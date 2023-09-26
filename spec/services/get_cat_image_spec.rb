require 'rails_helper'

RSpec.describe GetCatImage do

  describe '#execute' do
    context 'with valid attributes' do
      cat_image = CatImage.create!({
        name: 'Fluffy',
        age: 2,
        breed: 'Persian',
        status: CatImageStatus::ACTIVE,
        image: CatImageFile::OBJECT_TYPE.new(
            tempfile: Tempfile.new(['hello', '.png']),
            type: 'image/png',
            filename: 'original_file_name.png'
          )
      })

      it 'get the cat image' do
        result = described_class.run({ id: cat_image.id })

        expect(result).to be_valid
        expect(result.errors).to be_empty
        expect(result.result).to have_key(:data)

        data = result.result[:data]

        expect(data).to have_key(:id) and expect(data[:id]).to eql(cat_image.id)
        expect(data).to have_key(:name) and expect(data[:name]).to eql(cat_image.name)
        expect(data).to have_key(:age) and expect(data[:age]).to eql(cat_image.age)
        expect(data).to have_key(:breed) and expect(data[:breed]).to eql(cat_image.breed)
        expect(data).to have_key(:image_url)
        expect(data).to have_key(:created_at)
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
