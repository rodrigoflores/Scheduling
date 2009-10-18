#!/usr/bin/ruby -w


=begin
  * Name: hap_generator.rb
  * Description   
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
module Generator
  def Generator.generator_games(n)
    games = []
    (1..n).each do |team|
      if team == n
        second_team = 1 
      else
        second_team = team + 1
      end
      games << [team,second_team]
    end 
    games
  end
  
     
  def Generator.generate_round(number_of_teams,generator_game)
    round = [generator_game]
    (1...number_of_teams/2).each do |i|
      match = [normalize(generator_game.first - i, number_of_teams ),normalize(generator_game.last + i, number_of_teams)]
      round << match
    end
    round
  end
  
  def Generator.generate_schedule(number_of_teams)
    schedule = []
    generator_games = generator_games(5)  
    generator_games.each do |generator_game|
      schedule << generate_round(5,generator_game)      
    end
    schedule
  end

  private
  def Generator.normalize(x,n)
    if x <= 0
      x + n
    elsif x > n
      x - n
    else
      x
    end
  end

end
