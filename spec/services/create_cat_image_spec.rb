require 'rails_helper'

RSpec.describe CreateCatImage do

  describe '#execute' do
    context 'with valid attributes' do
      tempfile = Tempfile.new(['hello', '.png'])
      let(:attributes) { {
          name: 'Fluffy',
          age: 2,
          breed: 'Persian',
          image: CatImageFile::OBJECT_TYPE.new(
              tempfile: tempfile,
              type: 'image/png',
              filename: 'original_file_name.png'
            )
        } }

      it 'creates a CatImage' do
        result = described_class.run(attributes)

        expect(result).to be_valid
        expect(result.errors).to be_empty
        expect(result.result).to have_key(:id)

        cat_image = CatImage.find(result.result[:id])
        expect(cat_image).to be_present
        expect(cat_image.name).to eq('Fluffy')
        expect(cat_image.age).to eq(2)
        expect(cat_image.breed).to eq('Persian')
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
