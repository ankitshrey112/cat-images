require 'rails_helper'

RSpec.describe ListCatImages do

  describe '#execute' do
    context 'with valid attributes' do
      image = CatImageFile::OBJECT_TYPE.new(
        tempfile: Tempfile.new(['hello', '.png']),
        type: 'image/png',
        filename: 'original_file_name.png'
      )

      cat_images = [
        {
          name: 'name_1',
          age: 2,
          breed: 'Persian',
          status: CatImageStatus::ACTIVE,
          image: image
        },
        {
          name: 'name_2',
          age: 6,
          breed: 'British',
          status: CatImageStatus::ACTIVE,
          image: image
        },
        {
          name: 'name_3',
          age: 4,
          breed: 'Persian',
          status: CatImageStatus::ACTIVE,
          image: image
        },
        {
          name: 'name_4',
          age: 2,
          breed: 'British',
          status: CatImageStatus::ACTIVE,
          image: image
        },
        {
          name: 'name_5',
          age: 8,
          breed: 'British',
          status: CatImageStatus::ACTIVE,
          image: image
        },
        {
          name: 'name_6',
          age: 3,
          breed: 'Persian',
          status: CatImageStatus::ACTIVE,
          image: image
        },
        {
          name: 'name_7',
          age: 5,
          breed: 'British',
          status: CatImageStatus::ACTIVE,
          image: image
        },
        {
          name: 'name_8',
          age: 11,
          breed: 'Persian',
          status: CatImageStatus::ACTIVE,
          image: image
        },
        {
          name: 'name_9',
          age: 2,
          breed: 'British',
          status: CatImageStatus::ACTIVE,
          image: image
        },
        {
          name: 'name_10',
          age: 2,
          breed: 'Persian',
          status: CatImageStatus::ACTIVE,
          image: image
        }
      ]

      cat_images_objects = cat_images.map do |cat_image|
        CatImage.create!(cat_image)
      end.reverse

      it 'returns a list of cat images with default pagination data and most recent created' do
        result = described_class.run()

        expect(result).to be_valid
        expect(result.errors).to be_empty

        data = result.result
        count = CatImage.where(status: CatImageStatus::ACTIVE).count

        expect(data).to have_key(:list)
        expect(data).to have_key(:current_page) and expect(data[:current_page]).to eql(1)
        expect(data).to have_key(:current_count) and expect(data[:current_count]).to eql(10)
        expect(data).to have_key(:total_pages) and expect(data[:total_pages]).to eql(count/10 + (count%10 == 0 ? 0 : 1))
        expect(data).to have_key(:total_count) and expect(data[:total_count]).to eql(count)

        list = data[:list]

        cat_images_objects.each_with_index do |cat_image, index|
          list_obj = list[index]
          expect(list_obj).not_to be nil

          expect(list_obj).to have_key(:id) and expect(list_obj[:id]).to eql(cat_image.id)
          expect(list_obj).to have_key(:name) and expect(list_obj[:name]).to eql(cat_image.name)
          expect(list_obj).to have_key(:age) and expect(list_obj[:age]).to eql(cat_image.age)
          expect(list_obj).to have_key(:breed) and expect(list_obj[:breed]).to eql(cat_image.breed)
          expect(list_obj).to have_key(:image_url) and expect(list_obj[:image_url]).not_to be_empty
          expect(list_obj).to have_key(:created_at) and expect(list_obj[:created_at].to_s).not_to be_empty
        end
      end

      it 'returns a list of cat images with custom pagination data' do
        result = described_class.run({page: 2, per_page: 3})

        expect(result).to be_valid
        expect(result.errors).to be_empty

        data = result.result
        count = CatImage.where(status: CatImageStatus::ACTIVE).count

        expect(data).to have_key(:list)
        expect(data).to have_key(:current_page) and expect(data[:current_page]).to eql(2)
        expect(data).to have_key(:current_count) and expect(data[:current_count]).to eql(3)
        expect(data).to have_key(:total_pages) and expect(data[:total_pages]).to eql(count/3 + (count%3 == 0 ? 0 : 1))
        expect(data).to have_key(:total_count) and expect(data[:total_count]).to eql(count)

        list = data[:list]

        list.each do |list_obj|
          expect(list_obj).not_to be nil

          expect(list_obj).to have_key(:id) and expect(list_obj[:id].to_s).not_to be_empty
          expect(list_obj).to have_key(:name)
          expect(list_obj).to have_key(:age)
          expect(list_obj).to have_key(:breed)
          expect(list_obj).to have_key(:image_url) and expect(list_obj[:image_url]).not_to be_empty
          expect(list_obj).to have_key(:created_at) and expect(list_obj[:created_at].to_s).not_to be_empty
        end
      end
    end
  end
end
