require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    response = open(url).read
    response2 = JSON.parse(response)
    if response2["found"] == false
      @result  = "This is not an English word."
    elsif params[:word].upcase.chars.any? { |e| params[:word].upcase.count(e) > params[:letters].count(e) }
      @result = "This is not in the grid."
    else
      @result = "Congratulation! You cracked it!"
      @score = params[:word].length
    end
  end
end
