require 'spec_helper'
require 'assets/build_links'

describe BuildLinks do 

  describe "::date_to_gids_url" do
    
    context "given a date" do 
      let(:date) { Date.new(2015, 5, 3) }

      it "returns the appropriate gids url" do
        expected_date_url = "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03"
        date_url = BuildLinks.date_to_gids_url(date) 
        expect(date_url).to eq(expected_date_url)
      end
    end

  end

  describe "::parse_gids" do 

    context "given the gids url" do
  
      let(:date_url) { "http://gd2.mlb.com/components/game/mlb/year_2015/month_05/day_03" }

      it "finds the gids from the url" do 
        VCR.use_cassette 'lib/day_response' do 
          gids = BuildLinks.parse_gids(date_url)
          expected_gids = %w(gid_2015_05_03_anamlb_sfnmlb_1 gid_2015_05_03_arimlb_lanmlb_1                   gid_2015_05_03_chamlb_minlb_1               gid_2015_05_03_chamlb_minmlb_1             gid_2015_05_03_cinmlb_atlmlb_1                    gid_2015_05_03_colmlb_sdnmlb_1                 gid_2015_05_03_detmlb_kcamlb_1            gid_2015_05_03_milmlb_chnmlb_1            gid_2015_05_03_nyamlb_bosmlb_1             gid_2015_05_03_oakmlb_texmlb_1             gid_2015_05_03_phimlb_miamlb_1             gid_2015_05_03_pitmlb_slnmlb_1              gid_2015_05_03_seamlb_houmlb_1              gid_2015_05_03_tbamlb_balmlb_1               gid_2015_05_03_tormlb_clemlb_1            gid_2015_05_03_wasmlb_nynmlb_1)
          expect(gids).to eq(gids)
        end
      end

    end

  end

end