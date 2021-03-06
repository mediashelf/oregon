require 'datastreams/oregon_rdf_datastream'
require 'datastreams/workflow'
class Image < ActiveFedora::Base
  include Hydra::ModelMixins::RightsMetadata

  has_metadata :name => "descMetadata", :type => OregonRDFDatastream
  has_metadata :name => "rightsMetadata", :type => Hydra::Datastream::RightsMetadata
  has_metadata :name => "workflowMetadata", :type => Workflow

  has_and_belongs_to_many :collections, :property => :is_part_of

  # see https://github.com/mediashelf/sufia/blob/master/app/models/datastreams/file_content_datastream.rb
  has_file_datastream name: "content"
  has_file_datastream name: "thumbnail"

  delegate_to :descMetadata, [:hasFormat, :type, :location, :created, :description, :rights, :title, :subject, :identifier, :modified, :date]

  def to_solr(doc = {})
    doc = super
    doc["has_thumbnail_s"] = self.thumbnail.content.present?.to_s

    return doc
  end

  # Marks this image as having been reviewed and publishes it
  def review!
    workflowMetadata.review_process.status = "completed"
    self.read_groups += ["public"] unless self.read_groups.include?("public")
    save!
  end
end
