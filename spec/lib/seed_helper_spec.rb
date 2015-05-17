require 'spec_helper'
require 'assets/seed_helper'

describe SeedHelper do 

  describe "::seed_gid" do 

  end

  describe "::set_umpire" do 
    context "given umpire info that exists in the db" do 

      it "returns the umpire object" do 

      end
    end

    context "given umpire info that does not exist yet" do 
      let(:umpire_info) {
          {
            "first" => "Gary",
            "id" => "427058",
            "last" => "Cederstrom",
            "name" => "Gary Cederstrom",
            "position" => "home"
          }
      }


      it "creates the umpire object" do 
        SeedHelper.set_umpire(umpire_info)
        umpire = Umpire.find_by(mlb_umpire_id: 427058)
        expect(umpire.name).to eq("Gary Cederstrom")
        expect(umpire.mlb_umpire_id).to eq(427058)
      end
    end
  end

  describe "::set_game_type" do
    context "given a game xml url" do 

      let(:url) { "http://gd2.mlb.com/components/game/mlb/year_2015/month_04/day_14/gid_2015_04_14_nyamlb_balmlb_1/linescore.json" }

      it "returns the game type" do 
        VCR.use_cassette 'lib/game_type' do 
          game_type = SeedHelper.set_game_type(url)
          expect(game_type).to eq("R")
        end
      end
      
    end
  end

  describe "::get_umpire_info_from_gameday" do 
    context "given a players xml url" do 
      let(:url) { "http://gd2.mlb.com/components/game/mlb/year_2015/month_04/day_14/gid_2015_04_14_nyamlb_balmlb_1/players.xml" }

      let(:expected_umpire_info) {
        {
          "first" => "Gary",
          "id" => "427058",
          "last" => "Cederstrom",
          "name" => "Gary Cederstrom",
          "position" => "home"
        }
      }

      it "returns the umpire info from the gameday api" do 
        VCR.use_cassette 'lib/players' do 
          umpire_info = SeedHelper.get_umpire_info_from_gameday(url)
          expect(umpire_info).to eq(expected_umpire_info)
        end
      end 

    end
  end


end