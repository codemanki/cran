class Person < ActiveRecord::Base
  attr_accessible :version_id, :name, :is_maintainer
  belongs_to :version
end
