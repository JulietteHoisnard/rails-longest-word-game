require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    grid_size = 10
    @letters = grid_size.times.map { [*'A'..'Z'].sample }
  return @letters
  end

  def score
    @guess = params[:guess]
    @letters = params[:letters]
    if in_grid?(@guess.upcase, @letters) == true
      if english?(@guess) == true
        @result = "well done"
      else @result = "not an english word"
      end
    else @result = "not in the grid"
    end
    return @result
  end
  
  def english?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
  
  def in_grid?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end
end
