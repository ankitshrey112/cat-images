class CreateTableCatImages < ActiveRecord::Migration[7.0]
  def self.up
    create_table :cat_images do |t|
      t.string :name
      t.integer :age
      t.string :breed
      t.string :status

      t.timestamps

      t.index [:name], name: 'index_cats_on_name'
      t.index [:age], name: 'index_cats_on_age'
      t.index [:breed], name: 'index_cats_on_breed'
      t.index [:status], name: 'index_cats_on_status'
    end

    execute "ALTER TABLE cat_images ADD CONSTRAINT status_check CHECK (status IN ('active', 'inactive'))"
  end

  def self.down
    drop_table :cat_images
  end
end
