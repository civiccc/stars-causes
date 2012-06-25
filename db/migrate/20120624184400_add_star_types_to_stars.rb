class AddStarTypesToStars < ActiveRecord::Migration
  def self.up
    add_column :stars, :star_type, :string,
      :default => 'standard', :null => false
  end

  def self.down
    remove_column :stars, :star_type
  end
end
