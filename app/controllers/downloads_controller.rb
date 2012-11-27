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
  def show
    send_content (params["id"])
  end

  protected
  
  def send_content (id)
      @asset = ActiveFedora::Base.find(id)
      opts = {}
      ds = nil
      opts[:filename] = params["filename"] || @asset.label
      #opts[:disposition] = params["disposition"] if params.has_key?("disposition") 
      opts[:disposition] = 'inline' 

      # TODO: fixme if we want more dynamic ds download
      ds = @asset.thumbnail #datastreams[params[:datastream_id]]
      data = ds.content

      opts[:type] = ds.mimeType
      send_data data, opts
      return
  end
end
