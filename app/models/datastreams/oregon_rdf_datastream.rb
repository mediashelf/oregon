class OregonRDFDatastream < ActiveFedora::NtriplesRDFDatastream
  register_vocabularies RDF::DC
  map_predicates do |map|
    map.hasFormat(:in => RDF::DC) 
    map.subject(:in => RDF::DC) 
    map.type(:in => RDF::DC) 
    map.spatial(:in => RDF::DC) 
    map.created(:in => RDF::DC) 
    map.rights(:in => RDF::DC) 
    map.title(:in => RDF::DC) 
    map.identifier(:in => RDF::DC) 
    map.modified(:in => RDF::DC) 
    map.description(:in => RDF::DC) 
    map.date(:in => RDF::DC) 
  end

end
