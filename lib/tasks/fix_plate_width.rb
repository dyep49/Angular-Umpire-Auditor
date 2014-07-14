namespace :db do 
  desc "Recalculates pitch miss"
  task fix_plate_width: :environment do
    Pitch.all.each do |pitch|
      begin
        if (pitch.sz_top && (pitch.description == "Called Strike" || pitch.description == "Ball"))
          pitch.correct_call = pitch.correct_call? 
          if pitch.description == "Called Strike"
            pitch.distance_missed_x = pitch.x_miss
            pitch.distance_missed_y = pitch.y_miss
            pitch.total_distance_missed = pitch.total_miss
          end
          pitch.save!
        end
      rescue
      end
end
