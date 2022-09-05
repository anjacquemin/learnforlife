class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    filepath = "#{Rails.root}/db/seed_input/coordinates.csv"

    @lat_long_countries = []

    @question_answer = QuestionAnswer.all

    require "csv"

    index = 0

    CSV.foreach(filepath, headers: :first_row) do |row|
      # puts "#{row['NOM']} #{row['Affectation']} #{row['CAPITALE']}"
      index += 1
      @lat_long_countries << {
        country: row["name"],
        lat: row["latitude"],
        long: row["longitude"],
        map_index: "map#{index}"
      }
    end
  end
end
