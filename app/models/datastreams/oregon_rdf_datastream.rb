class OregonRDFDatastream < ActiveFedora::NtriplesRDFDatastream
  register_vocabularies RDF::DC, RDF::PREMIS, RDF::DWC, RDF::MARCREL
  map_predicates do |map|

    # Basic Dublin Core
    map.title(:in => RDF::DC) do |index|
      index.as :searchable, :displayable
    end
    map.creator(:in => RDF::DC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.contributor(:in => RDF::DC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.abstract(:in => RDF::DC) do |index|
      index.as :searchable, :displayable
    end
    map.description(:in => RDF::DC) do |index|
      index.as :searchable, :displayable
    end
    map.subject(:in => RDF::DC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.source(:in => RDF::DC) do |index|
      index.as :displayable
    end
    map.type(:in => RDF::DC) do |index|
      index.as :facetable, :displayable
    end
    map.location(:to => 'spatial', :in => RDF::DC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.rights(:in => RDF::DC) do |index|
      index.as :displayable
    end
    map.identifier(:in => RDF::DC) do |index|
      index.as :searchable, :displayable
    end
    map.created(:in => RDF::DC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.modified(:in => RDF::DC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.submissionDate(:to => 'dateSubmitted', :in => RDF::DC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.date(:in => RDF::DC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.format(:in => RDF::DC) do |index|
      index.as :facetable, :displayable
    end
    map.hasFormat(:to => 'hasFormat',:in => RDF::DC) # do not index
    map.localCollection(:to => 'isPartOf',:in => RDF::DC) # do not index
    map.replacesUrl(:to => 'isPartOf',:in => RDF::DC) # do not index

    # MARCRel
    # These fields should all be searchable as equivalent to dc.contributor
  # map.contributor[?](:to => "*", :in => RDF::MARCRel) do |index|
  #   index.as :searchable, :facetable, :displayable
  # end
    map.photograher(:to => 'pht', :in => RDF::MARCREL) do |index|
      index.as :searchable, :facetable, :displayable
    end

    # Darwin Core
    map.taxonClass(:to => 'class', :in => RDF::DWC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.order(:in => RDF::DWC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.family(:in => RDF::DWC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.genus(:in => RDF::DWC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.phylum(:in => RDF::DWC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.higherClassification(:in => RDF::DWC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.commonNames(:to => 'vernacularName', :in => RDF::DWC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    map.identificationVerificationStatus(:in => RDF::DWC) do |index|
      index.as :searchable, :facetable, :displayable
    end
    
    # PREMIS
    map.preservation(:to => 'originalName', :in => RDF::PREMIS)
    map.fixity(:in => RDF::PREMIS) # don't index

  end


  def to_solr(doc = {} )
    doc = super
    # Magic mystery fun code for making marc act like solr
    #doc["dc_contributor_t"] = doc["dc_photographer"] + ...
    doc
  end

end
