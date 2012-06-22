class Comment < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  belongs_to :star
  validates_presence_of :author, :body, :star
end
