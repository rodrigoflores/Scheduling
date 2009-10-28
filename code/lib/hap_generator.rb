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
    if(n.odd?)
			(1..n).each do |team|
      	if team == n
       		second_team = 1 
      	else
        	second_team = team + 1
      	end
      	games << [team,second_team]
    	end 
    	games
		else
			generator_games(n-1)
		end
  end
  
     
  def Generator.generate_round(number_of_teams,generator_game)
    if number_of_teams.odd? 
			round = [generator_game]
    	reverse = true
    	(1...number_of_teams/2).each do |i|
      	match = [normalize(generator_game.first - i, number_of_teams ),normalize(generator_game.last + i, number_of_teams)]
      	if reverse
        	round << match.reverse
      	else
        	round << match
      	end
      	reverse = !reverse 
    	end
		else
			round = generate_round(number_of_teams-1,generator_game)
			extra_game = [normalize(generator_game.first + number_of_teams/2,number_of_teams - 1),number_of_teams]
			if generator_game.first.even?
				extra_game.reverse!
			end
			round << extra_game
		end
   	round
  end
  
  def Generator.generate_schedule(number_of_teams)
    schedule = []
    generator_games = generator_games(number_of_teams)  
    generator_games.each do |generator_game|
      schedule << generate_round(number_of_teams,generator_game)      
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
