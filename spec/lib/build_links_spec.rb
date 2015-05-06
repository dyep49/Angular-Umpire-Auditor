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

end