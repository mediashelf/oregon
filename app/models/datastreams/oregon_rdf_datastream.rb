class OregonRDFDatastream < ActiveFedora::NtriplesRDFDatastream
  register_vocabularies RDF::DC
  map_predicates do |map|
    map.hasFormat(:in => RDF::DC) 
  end

end
