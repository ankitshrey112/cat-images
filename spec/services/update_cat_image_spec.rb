require 'rails_helper'

RSpec.describe UpdateCatImage do

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
          name: 'Fluffy_updated',
          age: 3,
          breed: 'British',
          performed_by_user_id: user.id,
          image: CatImageFile::OBJECT_TYPE.new(
              tempfile: Tempfile.new(['hello', '.png']),
              type: 'image/png',
              filename: 'updated_file_name.png'
            )
        } }

      it 'update the CatImage' do
        result = described_class.run(attributes)

        expect(result).to be_valid
        expect(result.errors).to be_empty
        expect(result.result).to have_key(:id)

        cat_image.reload
        expect(cat_image.name).to eq(attributes[:name])
        expect(cat_image.age).to eq(attributes[:age])
        expect(cat_image.breed).to eq(attributes[:breed])
        expect(cat_image.image.attached?).to be true
      end
    end

    context 'with invalid attributes' do
      let(:attributes) { { } }

      it 'returns errors' do
        result = described_class.run(attributes)
        
        expect(result).not_to be_valid
        expect(result.errors).not_to be_empty
      end
    end
  end
end
