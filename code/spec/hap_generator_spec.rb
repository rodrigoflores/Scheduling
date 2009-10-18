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
  it "Should say that true is true" do
    true.should be_true
  end
  
  describe "Given a number of teams" do
    it "Should return the generator game of each round" do
      Generator::generator_games(5).should == ["1 -> 2", "2 -> 3", "3 -> 4", "4 -> 5", "5 -> 1"]
      Generator::generator_games(9).should == ["1 -> 2", "2 -> 3", "3 -> 4", "4 -> 5", "5 -> 6","6 -> 7", "7 -> 8","8 -> 9", "9 -> 1"]
    end
  end

  describe "Given a generator game" do
    it "Should generate a round" do
      Generator::generate_round(5,1,2).should == ["1 -> 2","5 -> 3"] 
      Generator::generate_round(5,2,3).should == ["2 -> 3","4 -> 1"] 
      Generator::generate_round(5,3,4).should == ["3 -> 4","2 -> 5"] 
      Generator::generate_round(5,4,5).should == ["4 -> 5","1 -> 3"] 
      Generator::generate_round(5,5,1).should == ["5 -> 1","4 -> 2"] 
      Generator::generate_round(7,1,2).should == ["1 -> 2","7 -> 3","4 -> 6" ] 
      Generator::generate_round(7,2,3).should == ["2 -> 3","4 -> 1","7 -> 5" ] 
      Generator::generate_round(7,7,1).should == ["7 -> 1","6 -> 2","3 -> 5" ] 
    end    
    
  end

end


