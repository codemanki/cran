class Version < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :package
end
