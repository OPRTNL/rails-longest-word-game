class GamesController < ApplicationController
  def new
    @letters = Array('a'..'z').shuffle[1..10]
  end

  def score
    letters = params[:letters].split('')
    user_input = params[:answer].split('')
    if user_input.size > letters.size
      return @result = 'your input is not valiable'
    elsif compare(user_input, letters)
      @result = api_request(params[:answer]) ? 'input good !' : 'input false !'
    else
      return @result = 'your input is not valiable'
    end
  end

  private

  def api_request(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    user['found'] == true
  end

  def compare(user_input, new_array)
    user_input.each do |letter|
      if new_array.index(letter).nil?
        return false
      else
        number = new_array.index(letter)
        new_array.delete(number)
      end
    end
    true
  end
end
