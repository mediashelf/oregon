class OregonRDFDatastream < ActiveFedora::NtriplesRDFDatastream
  register_vocabularies RDF::DC, RDF::PREMIS
  map_predicates do |map|

    # Basic Dublin Core
    map.creator(:in => RDF::DC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.contributor(:in => RDF::DC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.abstract(:in => RDF::DC) do |index|
      index.as :searchable
    end
    map.description(:in => RDF::DC) do |index|
      index.as :searchable
    end
    map.subject(:in => RDF::DC) do |index|
      index.as :searchable, :facetable
    end
    map.type(:in => RDF::DC) do |index|
      index.as :searchable
    end
    map.spatial(:in => RDF::DC) do |index|
      index.as :searchable, :facetable
    end
    map.created(:in => RDF::DC) do |index|
      index.as :searchable
    end
    map.rights(:in => RDF::DC) do |index|
      index.as :searchable
    end
    map.title(:in => RDF::DC) do |index|
      index.as :searchable
    end
    map.identifier(:in => RDF::DC) do |index|
      index.as :searchable
    end
    map.modified(:in => RDF::DC) do |index|
      index.as :searchable
    end
    map.date(:in => RDF::DC) do |index|
      index.as :searchable, :facetable
    end
    map.format(:in => RDF::DC) do |index|
      index.as :searchable, :facetable
    end
    map.hasFormat(:to => 'hasFormat',:in => RDF::DC) # do not index

    # MARCRel
    # These fields should all be searchable as equivalent to dc.contributor
  # map.contributor[?](:to => "*", :in => RDF::MARCRel) do |index|
  #   index.as :searchable, :facetable, :displayable
  # end
    
    # PREMIS
    map.preservation(:to => 'originalName', :in => RDF::PREMIS) do |index|
      index.as :searchable
    end    
    map.fixity(:in => RDF::PREMIS) # don't index

  end


  # def to_solr(doc = {} )
  #   doc = super
  #   ### CUSTOM Behavior
  #   doc["my_field_t"] = 'Example text'
  #   doc
  # end

end
