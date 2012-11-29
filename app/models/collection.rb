class Collection < ActiveFedora::Base
  has_many :images, :property => :is_part_of
end
