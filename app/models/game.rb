class Game < ActiveRecord::Base
belongs_to :team
belongs_to :umpire
has_many :pitches


end