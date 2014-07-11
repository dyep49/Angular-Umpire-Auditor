namespace :db do 
  desc "Adds date formatted for image link to Day model"
  task add_img_date_to_day: :environment do
    Day.all.each do |day|
      date = day.game_date.strftime("%Y-%m-%d")
      day.img_date = date
      day.save!
    end
  end
end