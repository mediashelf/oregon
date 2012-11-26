require 'datastreams/oregon_rdf_datastream'
class Image < ActiveFedora::Base
  has_metadata :name => "descMetadata", :type => OregonRDFDatastream

  delegate_to :descMetadata, [:hasFormat, :type, :spatial, :created, :description, :rights, :title, :subject, :identifier, :modified, :date]
end
