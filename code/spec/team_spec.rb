
require File.join(File.dirname(__FILE__), "../lib" ,"team" )

describe "team" do
	it "Should initialize with a name, city and level" do
		team = Team::Team.new(:santos, :santos,1)
		team.name.should == :santos
		team.city.should == :santos
		team.level.should == 1
	end
end
