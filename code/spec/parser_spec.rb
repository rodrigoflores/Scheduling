
require File.join(File.dirname(__FILE__), "../lib" ,"parser" )

describe "parser" do
	describe "given a line with a level,team and city" do
		it "should return the level" do
			Parser::get_level("1:Santos:Santos").should == 1
			Parser::get_level("2:Portuguesa:São Paulo").should == 2
			Parser::get_level("3:Mirassol:Mirassol").should == 3
			Parser::get_level("4:Monte Azul:Monte Azul Paulista").should == 4
		end

		it "should return the team name as a symbol" do 
			Parser::get_team("1:Santos:Santos").should == :santos
			Parser::get_team("1:São Paulo:São Paulo").should == :sao_paulo
			Parser::get_team("1:Santo André:Santo André").should == :santo_andre
			Parser::get_team("1:Grêmio:Porto Alegre").should == :gremio
			Parser::get_team("1:Avaí:Florianópolis").should == :avai
			Parser::get_team("1:Náutico:Recife").should == :nautico
		end

		it "Should return the city name as a symbol" do
			Parser::get_city("1:Santos:Santos").should == :santos
			Parser::get_city("1:São Paulo:São Paulo").should == :sao_paulo
			Parser::get_city("1:Santo André:Santo André").should == :santo_andre
			Parser::get_city("1:Corinthians:São Paulo").should == :sao_paulo
			Parser::get_city("1:Avaí:Florianópolis").should == :florianopolis
			Parser::get_city("1:Goiás:Goiânia").should == :goiania
		end
	end
end
