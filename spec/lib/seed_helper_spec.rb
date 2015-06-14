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

  describe "::parse_pitch" do 
    context "given valid pitch hash" do 
      let(:valid_pitch) {
        {"des"=>"Called Strike",
         "des_es"=>"Strike cantado",
         "id"=>"254",
         "type"=>"S",
         "tfs"=>"002028",
         "tfs_zulu"=>"2015-04-15T00:20:28Z",
         "x"=>"96",
         "y"=>"145.52",
         "event_num"=>"254",
         "sv_id"=>"150414_202042",
         "play_guid"=>"cb0f93d6-07e7-4b34-906d-76bc5ba43f2e",
         "start_speed"=>"88.9",
         "end_speed"=>"81.1",
         "sz_top"=>"3.54",
         "sz_bot"=>"1.57",
         "pfx_x"=>"-4.18",
         "pfx_z"=>"10.26",
         "px"=>"0.551",
         "pz"=>"3.454",
         "x0"=>"-1.078",
         "y0"=>"50.0",
         "z0"=>"6.234",
         "vx0"=>"5.556",
         "vy0"=>"-130.177",
         "vz0"=>"-4.251",
         "ax"=>"-7.103",
         "ay"=>"29.776",
         "az"=>"-14.668",
         "break_y"=>"23.7",
         "break_angle"=>"20.6",
         "break_length"=>"4.0",
         "pitch_type"=>"FF",
         "type_confidence"=>".877",
         "zone"=>"3",
         "nasty"=>"69",
         "spin_dir"=>"202.083",
         "spin_rate"=>"2105.469",
         "cc"=>"",
         "mt"=>""}
      }

      let(:pitch_hash) {
        {:description=>"Called Strike",
         :pid=>"254",
         :x_location=>"0.551",
         :y_location=>"3.454",
         :sz_top=>"3.54",
         :sz_bottom=>"1.57",
         :sv_id=>"150414_202042",
         :type_id=>"S",
         :missing_data=>false}
      }
            
      it "returns a pitch hash with no missing data" do
        parsed_pitch = SeedHelper.parse_pitch(valid_pitch)          
        expect(parsed_pitch).to eq(pitch_hash)  
      end
    end

    context "given pitch xml with missing data" do 
                
      let(:invalid_pitch) {
        {"des"=>"Called Strike",
         "des_es"=>"Strike cantado",
         "id"=>"254",
         "type"=>"S",
         "tfs"=>"002028",
         "tfs_zulu"=>"2015-04-15T00:20:28Z",
         "x"=>"96",
         "y"=>"145.52",
         "event_num"=>"254",
         "sv_id"=>"150414_202042",
         "play_guid"=>"cb0f93d6-07e7-4b34-906d-76bc5ba43f2e",
         "start_speed"=>"88.9",
         "end_speed"=>"81.1",
         "sz_top"=>"3.54",
         "pfx_x"=>"-4.18",
         "pfx_z"=>"10.26",
         "px"=>"0.551",
         "pz"=>"3.454",
         "x0"=>"-1.078",
         "y0"=>"50.0",
         "z0"=>"6.234",
         "vx0"=>"5.556",
         "vy0"=>"-130.177",
         "vz0"=>"-4.251",
         "ax"=>"-7.103",
         "ay"=>"29.776",
         "az"=>"-14.668",
         "break_y"=>"23.7",
         "break_angle"=>"20.6",
         "break_length"=>"4.0",
         "pitch_type"=>"FF",
         "type_confidence"=>".877",
         "zone"=>"3",
         "nasty"=>"69",
         "spin_dir"=>"202.083",
         "spin_rate"=>"2105.469",
         "cc"=>"",
         "mt"=>""}
      }

      let(:parsed_invalid_pitch) {
        {:description=>"Called Strike",
         :pid=>"254",
         :x_location=>"0.551",
         :y_location=>"3.454",
         :sz_top=>"3.54",
         :sz_bottom=>nil,
         :sv_id=>"150414_202042",
         :type_id=>"S",
         :missing_data=>true}
      } 

      it "returns a pitch hash with missing data" do 
          parsed_pitch = SeedHelper.parse_pitch(invalid_pitch)
          expect(parsed_pitch).to eq(parsed_invalid_pitch) 
      end    
    end
  end

end
