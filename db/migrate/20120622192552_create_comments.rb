class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :body
      t.integer :author_id
      t.integer :star_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
