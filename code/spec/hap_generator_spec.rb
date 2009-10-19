#!/usr/bin/ruby -w


=begin
  * Name: hap_generator_spec.rb
  * Test for hap_generator 
  * Author: Rodrigo Flores (mail@rodrigoflores.org)
  * Date: 10/18/2009 
  * License: MIT License 

Copyright (c) 2009, Rodrigo Flores <mail@rodrigoflores.org>

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.


=end

require File.join(File.dirname(__FILE__), "../lib" ,"hap_generator" )

describe "HAP generator" do
  describe "Given a number of teams" do
    it "Should return the generator game of each round" do
      Generator::generator_games(5).should == [[1,2], [2,3], [3,4],[4,5],[5,1]]
      Generator::generator_games(9).should == [[1,2], [2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,1]]
      Generator::generator_games(10).should == [[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10],[10,1]]
    end
  end

  describe "Given a generator game" do
    describe "Should generate a round" do
      
      it "Should return only the generator game when we only have 2 or 3 teams" do
        Generator::generate_round(3,[1,2]).should == [[1,2]]
        Generator::generate_round(3,[1,2]).should == [[1,2]]
        Generator::generate_round(3,[2,3]).should == [[2,3]]
        Generator::generate_round(3,[3,1]).should == [[3,1]]
      end    
      
      it "Should return [[1,2],[5,3] when we have 5 teams with [1,2] generating" do 
        Generator::generate_round(5,[1,2]).should == [[1,2],[3,5]]
      end
      
      it "Should return [[2,3],[1,5] when we have 5 teams with [2,3] generating" do 
        Generator::generate_round(5,[2,3]).should == [[2,3],[4,1]]
      end
      
      it "Should return [[3,4],[2,5] when we have 5 teams with [3,4] generating" do 
        Generator::generate_round(5,[3,4]).should == [[3,4],[5,2]]
      end

      it "Should return [[4,5],[3,1] when we have 5 teams with [4,5] generating" do 
        Generator::generate_round(5,[4,5]).should == [[4,5],[1,3]]
      end

      it "Should return [[5,1],[4,2]] when we have 5 teams with [5,1] generating" do 
        Generator::generate_round(5,[5,1]).should == [[5,1],[2,4]]
      end

    end
  end
  
  it "Should return a complete schedule for 5 teams" do
    Generator::generate_schedule(5).should == [[[1,2],[3,5]],
                                               [[2,3],[4,1]],
                                               [[3,4],[5,2]],
                                               [[4,5],[1,3]],
                                               [[5,1],[2,4]]]  
  end 
end

