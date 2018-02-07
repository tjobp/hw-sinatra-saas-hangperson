class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
    
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word
  attr_accessor :word_with_guesses
  attr_accessor :check_win_or_lose

  # Get a word from remote "random word" service

  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = " "
    for i in 0...@word.length
      @word_with_guesses[i] = "-"
    end
    @check_win_or_lose = :play

  end

def guess(letter)
  
  unless letter =~ /[[:alpha:]]/
    raise ArgumentError.new("Guess is not a letter")
  end
  unless letter =~ /\w/
    raise ArgumentError.new("Guess is not a letter")
  end
  if letter == nil
    raise ArgumentError.new("Guess is not a letter")
  end
  
  letter = letter.downcase
  
    if @guesses.include? letter
      return false
    elsif @wrong_guesses.include? letter
      return false
    elsif @word.include? letter
      @guesses << letter
      for pos in 0...@word.length
        if @word[pos].chr == letter
          @word_with_guesses[pos] = letter
        end
      end
      if @word == @word_with_guesses
          @check_win_or_lose = :win
      end
      return true
    else 
      @wrong_guesses << letter
      if @wrong_guesses.length >= 7
        @check_win_or_lose = :lose
      end
      return true
    end
    
end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
