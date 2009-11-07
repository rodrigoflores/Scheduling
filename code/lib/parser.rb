#!/usr/bin/ruby -w


=begin
  * Name: parser.rb
  * Does the parsing in the team file
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
module Parser
	def Parser.get_level(stream) 
		stream.split(":").first.to_i
	end

	def Parser.get_team(stream)
		team = stream.split(":")[1]
		team.downcase.gsub(" ","_").gsub("ã","a").gsub("é","e").to_sym
	end

	def Parser.get_city(stream)
		city = stream.split(":")[2]
		city.downcase.gsub(" ","_").gsub("ã","a").gsub("é","e").to_sym
	end

end
