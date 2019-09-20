require "byebug"

class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman::random_word
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    indices = []
    @secret_word.each_char.with_index do |ch, idx|
      if char == ch
        indices << idx
      end
    end
    indices
  end

  def fill_indices(char, arr)
    arr.each {|index| @guess_word[index] = char}
  end

  def try_guess(char)
    if already_attempted?(char)
      puts 'that has already been attempted'
      return false
    else
      @attempted_chars << char
    end
    
    matching_indices = get_matching_indices(char)
    if matching_indices.length > 0
      fill_indices(char, matching_indices)
    else
      @remaining_incorrect_guesses -= 1
    end

    true
  end

  def ask_user_for_guess
    print "Enter a char: "
    char = gets.chomp
    try_guess(char)
  end

  def win?
    @guess_word.each_with_index do |char, idx|
      if char != @secret_word[idx]
        return false
      end
    end
    print "WIN"
    true
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      print "LOSE"
      return true
    end

    false
  end

  def game_over?
    if win? || lose?
      print @secret_word
      return true
    end

    false
  end
end