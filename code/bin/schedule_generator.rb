#!/usr/bin/ruby -w

$LOAD_PATH.push File.join(File.dirname(__FILE__),"..","lib")


require "parser"
require "team"
require "hap_generator"
require "combo"

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


=begin
  puts "Now I will assume that you don't want to minimize (our maximize) anything."
  puts "So I will randomly assign for each team a random number from 1 to size of the team list"

  integers = (1..teams.size).to_a

  rand(20).times do 
    integers.shuffle!
  end

  teams.each_with_index do |team,index|
    printf "%d %s",integers[index] ,team
  end 

  schedule.each_with_index do |round,index|
    puts "Round #{index+1}"
    round.each do |match|
      puts teams[match.first - 1].name.to_s + " X " + teams[match.last - 1].name.to_s
    end
  end
=end

def teams_from_city(teams)
  city_teams = {}
  teams.each do |team|
    if city_teams[team.city]
      city_teams[team.city] << team
    else
      city_teams[team.city] = [team]
    end
  end
  city_teams
end

city_teams = teams_from_city(teams)
city_teams.each_key do |city|
  puts city.to_s
  city_teams[city].each do |team|
    puts "\t"+team.name.to_s
  end
end

sp_teams = ["sao paulo","palmeiras","corinthians","portuguesa"]
puts sp_teams
integers = (1..20).to_a 

combinations = integers.combinations(sp_teams.size)

def get_home_away_teams(round)
  home_teams = []
  away_teams = []
  round.each do |match|
    home_teams << match.first
    away_teams << match.last
  end
  [home_teams,away_teams]
end

def compute_fine(combination,schedule)
  fine = 0
  schedule.each do |round|
    arrays_home_array = get_home_away_teams(round)

    home_teams = arrays_home_array.first
    away_teams = arrays_home_array.last
    home_teams_in_combination = 0
    away_teams_in_combination = 0
    combination.each do |team|
      if home_teams.include?(team)
        home_teams_in_combination += 1
      else
        away_teams_in_combination += 1
      end
    end
    if home_teams_in_combination > 2 || away_teams_in_combination > 2 
      fine += 100
    end
  end
  fine
end



combinations.each do |combination|
  puts combination.join(sep=",") if compute_fine(combination,schedule) == 0
end


