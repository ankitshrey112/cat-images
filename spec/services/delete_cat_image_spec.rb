require 'rails_helper'

RSpec.describe DeleteCatImage do

  describe '#execute' do
    User.delete_all
    user1 = User.create!({email: 'test@test.com', password: 'test123'})
    user2 = User.create!({email: 'test2@test.com', password: 'test123'})

    cat_image = CatImage.create!({
        name: 'Fluffy',
        age: 2,
        breed: 'Persian',
        status: CatImageStatus::ACTIVE,
        created_by_user_id: user1.id,
        image: CatImageFile::OBJECT_TYPE.new(
            tempfile: Tempfile.new(['hello', '.png']),
            type: 'image/png',
            filename: 'original_file_name.png'
          )
      })

    context 'with valid attributes' do
      let(:attributes) { {
          id: cat_image.id,
          performed_by_user_id: user1.id
        } }

      it 'with a valid ID' do
        result = described_class.run(attributes)

        expect(result).to be_valid
        expect(result.result).to have_key(:id)

        cat_image.reload
        expect(cat_image.status).to eq(CatImageStatus::INACTIVE)
      end
    end

    context 'returns an error' do
      let(:attributes) { {
          id: -1, # Assuming -1 is an invalid ID
          performed_by_user_id: user1.id
        } }

      it 'returns not found error' do
        begin
          described_class.run(attributes)
        rescue CustomError => e
          expect(e.status).to eql(APIStatus::NOT_FOUND)
        end
      end

      it 'returns forbidden error' do
        begin
          described_class.run({ id: cat_image.id, performed_by_user_id: user2.id })
        rescue CustomError => e
          expect(e.status).to eql(APIStatus::FORBIDDEN)
        end
      end
    end
  end
end
