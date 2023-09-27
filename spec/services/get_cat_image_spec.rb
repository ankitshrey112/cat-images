require 'rails_helper'

RSpec.describe GetCatImage do

  describe '#execute' do
    User.delete_all
    user = User.create!({email: 'test@test.com', password: 'test123'})

    context 'with valid attributes' do
      cat_image = CatImage.create!({
        name: 'Fluffy',
        age: 2,
        breed: 'Persian',
        status: CatImageStatus::ACTIVE,
        created_by_user_id: user.id,
        image: CatImageFile::OBJECT_TYPE.new(
            tempfile: Tempfile.new(['hello', '.png']),
            type: 'image/png',
            filename: 'original_file_name.png'
          )
      })

      let(:attributes) { {
          id: cat_image.id,
          performed_by_user_id: user.id
        } }

      it 'get the cat image' do
        result = described_class.run(attributes)

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
      let(:attributes) { {
          id: -1, # Assuming -1 is an invalid ID
          performed_by_user_id: user.id
        } }

      it 'returns errors' do
        begin
          described_class.run(attributes)
        rescue CustomError => e
          expect(e.status).to eql(APIStatus::NOT_FOUND)
        end
      end
    end
  end
end
