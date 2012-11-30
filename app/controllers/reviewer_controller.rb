# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class ReviewerController < ApplicationController  

  include Blacklight::Catalog
  # Extend Blacklight::Catalog with Hydra behaviors (primarily editing).
  include Hydra::Controller::ControllerBehavior

  # These before_filters apply the hydra access controls
  before_filter :restrict_to_reviewer

  # This filters out objects that you want to exclude from search results, like FileAssets
  self.solr_search_params_logic << :exclude_unwanted_models
  self.solr_search_params_logic << :exclude_collections
  self.solr_search_params_logic << :exclude_reviewed

  copy_blacklight_config_from(CatalogController)

  def index
    super
    render "catalog/index"
  end

  def show
    super
    render "catalog/show"
  end

  def restrict_to_reviewer
    unless can? :review, Image
      raise raise Hydra::AccessDenied.new "You do not have permission to review"
    end
  end

  def exclude_collections(solr_parameters, user_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "-has_model_s:\"info:fedora/afmodel:Collection\""
  end

  def exclude_reviewed(solr_parameters, user_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "needs_review_s:\"true\""
  end
end 
