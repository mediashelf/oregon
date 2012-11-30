# -*- coding: undecided -*-
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

describe OregonDigital::IdService do
  describe "mint" do
    before(:all) do
      @id = OregonDigital::IdService.mint
    end

    it "should create a unique id" do
      @id.should_not be_empty
    end
    it "should not mint the same id twice in a row" do
      other_id = OregonDigital::IdService.mint
      other_id.should_not == @id
    end
    it "should create many unique ids" do
      a = []
      threads = (1..10).map do
        Thread.new do
          100.times do
            a <<  OregonDigital::IdService.mint
          end
        end
      end
      threads.each(&:join)     
      a.uniq.count.should == a.count
    end
    it "should create many unique ids when hit by multiple processes " do
      rd, wr = IO.pipe
      2.times do
        pid = fork do 
          rd.close
          threads = (1..10).map do
            Thread.new do
              20.times do
                wr.write OregonDigital::IdService.mint
                wr.write " "
              end
            end
          end
          threads.each(&:join)        
          wr.close
        end
      end
      wr.close
      2.times do
        Process.wait
      end
      s = rd.read
      rd.close
      a = s.split(" ")
      a.uniq.count.should == a.count
    end
  end

end
