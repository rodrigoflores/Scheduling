#!/usr/bin/ruby -w
# encoding: utf-8

$LOAD_PATH.push File.join(File.dirname(__FILE__),"..","lib")


require "parser"
require "team"
require "hap_generator"
require "combo"

USAGE = <<EOF

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

EOF

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

city_that_has_more_than_one_team = []
city_that_has_one_team = []
city_teams.each_key do |city|
  if city_teams[city].size >= 2
    city_that_has_more_than_one_team << city
  else
    city_that_has_one_team << city
  end
end


def get_home_away_teams(round)
  home_teams = []
  away_teams = []
  round.each do |match|
    home_teams << match.first
    away_teams << match.last
  end
  [home_teams,away_teams]
end

def valid_pair?(schedule,x,y)
  schedule.each do |round|
    arrays_home_array = get_home_away_teams(round)
    array_home = arrays_home_array.first
    array_away = arrays_home_array.last
    if (array_home.include?(x) && array_home.include?(y)) || (array_away.include?(x) && array_away.include?(y))
      return false
    end 
  end
  true
end


pairs = []
(1..teams.size).to_a.combinations(2).each do |combination|
  pairs << combination  if valid_pair?(schedule,combination.first,combination.last)
end

pairs.each do |pair|
	puts pair.join(sep=",")
end

puts "I have the pairs. Let me assign a random pair for a pair of teams"

assignments = []

city_that_has_more_than_one_team.each do |city|
	puts "Teams from: " + city.to_s
	while city_teams[city].size > 1
		team1 = city_teams[city].random_element
		team2 = city_teams[city].random_element
		puts "I got #{team1.name} and #{team2.name}"
		pair = pairs.random_element 
		puts "I got the pair #{pair.first} #{pair.last} "
		assignments[pair.random_element] = team1
		assignments[pair.random_element] = team2 
	end
	if city_teams[city].size == 1
		city_that_has_one_team << city
	end
end

remained_teams = []
city_that_has_one_team.each do |city|
	team = city_teams[city].first
	remained_teams << team
end


(1..teams.size).to_a.each do |index|
	if assignments[index].nil?
		team = remained_teams.random_element
		puts "Team #{team.name} in index #{index}"
		assignments[index] = team
	end
end


assignments.each_with_index do |as,index|
	if index != 0 
		printf "#{index} #{as.name}\n" 
	end
end

puts "We have the assignments, now we will generate the season schedule: "

puts
printf "%20s\t%20s X %20s\n","City","Home Team", "Away Team"
puts


puts
puts "First Leg "
puts

schedule.each_with_index do |round,index|
	puts "Round #{index+1}"
	puts
	round.each do |match|
		printf "%20s\t%20s X %20s\n",assignments[match.first].city,assignments[match.first].name,assignments[match.last].name
	end
	puts
end

puts
puts "Second Leg "
puts

schedule.each_with_index do |round,index|
	puts "Round #{index+20}"
	puts
	round.each do |match|
		printf "%20s\t%20s X %20s\n",assignments[match.last].city,assignments[match.last].name,assignments[match.first].name
	end
	puts
end


