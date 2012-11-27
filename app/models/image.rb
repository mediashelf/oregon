require 'datastreams/oregon_rdf_datastream'
class Image < ActiveFedora::Base
  has_metadata :name => "descMetadata", :type => OregonRDFDatastream

  delegate_to :descMetadata, [:creator, :contributor, :abstract, :description, :type, :spatial, :created, :rights, :title, :subject, :identifier, :modified, :date, :hasFormat, :format, :preservation, :fixity]
end
