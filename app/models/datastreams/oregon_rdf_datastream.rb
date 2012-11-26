class OregonRDFDatastream < ActiveFedora::NtriplesRDFDatastream
  register_vocabularies RDF::DC
  map_predicates do |map|
    map.hasFormat(:in => RDF::DC) do |index|
      index.as :searchable, :facetable
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
 
    map.description(:in => RDF::DC) do |index|
      index.as :searchable
    end
 
    map.date(:in => RDF::DC) do |index|
      index.as :searchable, :facetable
    end
 
  end


  # def to_solr(doc = {} )
  #   doc = super
  #   ### CUSTOM Behavior
  #   doc["my_field_t"] = 'Example text'
  #   doc
  # end

end
