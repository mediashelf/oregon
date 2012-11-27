# Copyright © 2012 The Pennsylvania State University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class DownloadsController < ApplicationController
  # module mixes in normalize_identifier method
  include Sufia::Noid

  # moved check into the routine so we can handle the user with no access 
  #before_filter :deny_access_if_not_reader, :only=>[:show]
  prepend_before_filter :normalize_identifier, :only=>[:audit, :edit, :show, :update, :destroy] 
  
  def show
    if can? :read, permissions_solr_doc_for_id(params["id"])
      logger.info "Can read #{params['id']}"

      send_content (params["id"])
      return
    else 
      logger.info "Can not read #{params['id']}"
      redirect_to "/assets/NoAccess.png"
    end
  end

  protected
  
  def send_content (id)
      @asset = ActiveFedora::Base.find(id)
      opts = {}
      ds = nil
      opts[:filename] = params["filename"] || @asset.label
      #opts[:disposition] = params["disposition"] if params.has_key?("disposition") 
      opts[:disposition] = 'inline' 
      if params.has_key?(:datastream_id)
        opts[:filename] = params[:datastream_id]
        ds = @asset.datastreams[params[:datastream_id]]
      end
      ds = default_content_ds(@asset) if ds.nil?
      data = ds.content
      opts[:type] = ds.mimeType
      send_data data, opts
      return
  end
  
  
  private 
  
  def default_content_ds(asset)
    ActiveFedora::ContentModel.known_models_for(asset).each do |model_class|
      return model_class.default_content_ds if model_class.respond_to?(:default_content_ds)
    end
    if asset.datastreams.keys.include?(DownloadsController.default_content_dsid)
      return asset.datastreams[DownloadsController.default_content_dsid]
    else
      return asset.inner_object.profile.to_xml
    end
  end
  
  def self.default_content_dsid
    "content"
  end
  
  # Custom enforcement for show requests -- redirects to catalog_path if not reader.
  def deny_access_if_not_reader
    authenticate_user!
    load_permissions_from_solr
    unless can? :read, @permissions_solr_document
      redirect_to catalog_path
      return
    end
  end  
end
