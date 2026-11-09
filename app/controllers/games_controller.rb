class GamesController < ApplicationController
  require "open-uri"
  require "json"
  def new
    @letters = []
    10.times do
      @letters << ("A".."Z").to_a.sample
    end
  end

  def score
    letters = params[:letters].split
    word = params[:word].upcase

    buildable = true
    word.chars.each do |letter|
      if word.count(letter) > letters.count(letter)
        buildable = false
      end
    end

    if buildable == false
      @result = "Sorry but #{word} can't be built out of #{letters}"
    else
      url = "https://dictionary.lewagon.com/#{word.downcase}"
      response = URI.parse(url).read
      data = JSON.parse(response)

      if data["found"] == true
        @result = "Congratulations! #{word} is a valid English word!"
      else
        @result = "Sorry but #{word} does not seem to be a valid English word...."
      end
    end
  end
end
