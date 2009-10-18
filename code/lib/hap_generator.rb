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
      
      games << "#{team} -> #{second_team}"
    end 
    games
  end
  def Generator.generate_round(number_of_teams, home_main, away_main)
    games = []
    if home_main % 2 == 0
      order = -1
    else
      order = 1
    end
    games << "#{home_main} -> #{away_main}"
    (1...(number_of_teams/2)).each do |i|
      team_a = home_main - i
      if home_main - i <= 0
        team_a += number_of_teams
      end
      
      team_b = away_main + i
      if away_main + i > number_of_teams
        team_b -= number_of_teams
      end

      if order == 1 
        games << "#{team_a} -> #{team_b}"
      else
        games << "#{team_b} -> #{team_a}"
      end
      order *= -1
    end
    games
  end
end
