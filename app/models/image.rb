require 'datastreams/oregon_rdf_datastream'
class Image < ActiveFedora::Base
  has_metadata :name => "descMetadata", :type => OregonRDFDatastream

  # see https://github.com/mediashelf/sufia/blob/master/app/models/datastreams/file_content_datastream.rb
  has_file_datastream :name => "content"

  delegate_to :descMetadata, [:hasFormat, :type, :spatial, :created, :description, :rights, :title, :subject, :identifier, :modified, :date]
end
