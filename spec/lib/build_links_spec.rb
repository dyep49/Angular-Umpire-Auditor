require 'spec_helper'
require 'assets/build_links'

describe BuildLinks do 

  describe "::parse_gids_by_date" do 
    context "given a date" do 
      let(:date) { Date.new(2015, 5, 3) }

      let(:expected_gids) { ["http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_anamlb_sfnmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_arimlb_lanmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_chamlb_minmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_cinmlb_atlmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_colmlb_sdnmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_detmlb_kcamlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_milmlb_chnmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_nyamlb_bosmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_oakmlb_texmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_phimlb_miamlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_pitmlb_slnmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_seamlb_houmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_tbamlb_balmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_tormlb_clemlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_wasmlb_nynmlb_1"] }

      it "returns an array of gid urls" do 
        VCR.use_cassette 'lib/day_response' do 
          gid_urls = BuildLinks.parse_gids_by_date(date)
          expect(gid_urls).to eq (expected_gids)
        end
      end

    end
  end

  # describe "::date_to_gids_url" do
    
  #   context "given a date" do 
  #     let(:date) { Date.new(2015, 5, 3) }

  #     it "returns the appropriate gids url" do
  #       expected_date_url = "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03"
  #       date_url = BuildLinks.date_to_gids_url(date) 
  #       expect(date_url).to eq(expected_date_url)
  #     end
  #   end

  # end

  # describe "::parse_gids" do 

  #   context "given the day url" do
  
  #     let(:date_url) { "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03" }

  #     let(:expected_gids) { ["http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_anamlb_sfnmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_arimlb_lanmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_chamlb_minmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_cinmlb_atlmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_colmlb_sdnmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_detmlb_kcamlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_milmlb_chnmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_nyamlb_bosmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_oakmlb_texmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_phimlb_miamlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_pitmlb_slnmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_seamlb_houmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_tbamlb_balmlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_tormlb_clemlb_1", "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03/gid_2015_05_03_wasmlb_nynmlb_1"] }

  #     it "hits the api and parses an array of gid urls" do 
  #       VCR.use_cassette 'lib/day_response' do 
  #         gids = BuildLinks.parse_gids(date_url)
  #         expect(gids).to eq(expected_gids)
  #       end
  #     end

  #   end

  # end



end