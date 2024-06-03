require "json"
require "open-uri"
class GamesController < ApplicationController

  def new
    o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
    @letters = (0...10).map { o[rand(o.length)] }
  end

  def score
    @word = params[:word]
    @grilleletters = params[:reelletters]
    @url = "https://dictionary.lewagon.com/#{@word}"
    user_serialized = URI.open(@url).read
    @check = JSON.parse(user_serialized)
    if @word.upcase.chars.all? { |letter| @word.upcase.chars.count(letter) <= @grilleletters.upcase.strip.chars.count(letter)}
      if @check["found"] == true
        @response = "Bien ! #{@word.upcase} est bien un mot english"
        @score = calculate_score(@word)
      else
        @response = "Desolé mais #{@word.upcase} n'est pas dans #{@grilleletters.upcase} "
        @score = 0
      end
    else
      @response = "#{@word.upcase} not found in english"
    end

    private

    def calculate_score(word)
    @word.size
    end
  end
end
