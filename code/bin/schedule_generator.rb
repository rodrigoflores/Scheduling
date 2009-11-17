$LOAD_PATH.push File.join(File.dirname(__FILE__),"..","lib")

require "parser"
require "team"
require "hap_generator"

USAGE = <<END

Welcome to schedule generator!

If you're reading this, you don't know how to use
this software or you want to know how to run 
succesfully. So here is the usage:

schedule_generator SCHEDULE_FILE

Here is a schedule file example (With level,team and city):

1:Palmeiras:São Paulo
1:São Paulo:São Paulo
1:Corinthians:São Paulo
1:Santos:Santos
1:Barueri:Barueri

Please, do not forget the ":". They are really important
for the parser. Team names and city names can be so strange
and it is a really made my work easily.

Another error that made you read this is an erroneous 
schedule_file. So please watch carefully.

If you like this program, please send me a postcard! 

END

if ARGV[0].nil?
  puts USAGE
  exit
end

file = File.open(ARGV[0])

teams = []

while(line = file.gets)
  if line =~ /.+:.+:.+/
    unless line == "Level:Team:City\n"
      teams << Team::Team.new(Parser.get_team(line),Parser.get_city(line),Parser.get_level(line))
    end
  else
    puts USAGE
    exit
  end
end

puts "Thanks. I've read the file"
puts "Here is your teams:"

teams.each do |team|
  puts team
end

puts "Now I will generate the hap patterns"

schedule = Generator::generate_schedule(teams.size)

puts "Hap patterns generated"

puts "Now I will assume that you don't want to minimize (our maximize) anything."
puts "So I will randomly assign for each team a random number from 1 to size of the team list"

integers = (1..teams.size).to_a
integers.shuffle!

teams.each_with_index do |team,index|
  printf "%d %s",integers[index] ,team
end 

schedule.each_with_index do |round,index|
  puts "Round #{index+1}"
  round.each do |match|
    puts teams[match.first - 1].name.to_s + " X " + teams[match.last - 1].name.to_s
  end
end

