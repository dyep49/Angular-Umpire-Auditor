module DataCleaner

  def self.clean_pitch(pitch_id)

    pitch = Pitch.find(pitch_id)

    game = pitch.game

    pitch.missing_data = true
    pitch.total_distance_missed = 0
    pitch.distance_missed_y = 0
    pitch.distance_missed_x = 0
    pitch.save!

    self.reset_calls(game)

    Game.set_calls(game)D

    day = Day.find_by(game_date: game.game_date)
    day.destroy!

    Day.create_days([game])
  end

  def self.reset_calls(game)
    game.correct_calls = 0
    game.incorrect_calls = 0
    game.total_calls = 0
    game.percent_correct = 0
    game.save!
  end


end