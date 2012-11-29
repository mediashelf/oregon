# TODO: Long-term, look at the "official" version for ideas:
# https://github.com/sul-dlss/dor-services/blob/master/lib/dor/datastreams/workflow_definition_ds.rb
class Workflow < ActiveFedora::NokogiriDatastream
  set_terminology do |t|
    t.root :path => "workflow"
    t.process do
      t.name :path => {:attribute => "name"}
      t.status :path => {:attribute => "status"}
      t.datetime :path => {:attribute => "datetime"}
      t.attempts :path => {:attribute => "attempts"}
      t.elapsed :path => {:attribute => "elapsed"}
      t.lifecycle :path => {:attribute => "lifecycle"}
      t.message :path => {:attribute => "message"}
      t.text :path => {:attribute => "text"}
    end

    t.review_process :path => "process[@name='review-metadata']" do
      t.status :path => {:attribute => "status"}
    end
  end

  def self.xml_template
    Nokogiri::XML(%Q|
      <workflow id="imageWF" status="active">
        <process name="ingest-object" status="waiting" attempts="0" />
        <process name="review-metadata" status="waiting" attempts="0" />
        <process name="build-derivatives" status="waiting" attempts="0" />
        <process name="publish" status="waiting" attempts="0" />
      </workflow>
    |)
  end

  def needs_review?
    self.review_process.status.first == "waiting"
  end

  def to_solr(doc = {})
    doc = super
    doc["needs_review_s"] = needs_review?.to_s
    return doc
  end
end
