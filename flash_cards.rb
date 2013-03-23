# Authors: Alex Ray, Conor Flanagan, Nick Ibanez, Joshua Teng

module DeckData

  #I already made changes dude
  #Josh says hello!

  def self.cards(file)
    card_data_raw = File.open(file).readlines
    definition = []
    answer = []

    card_data_raw.each_with_index do |line, index|
      if index % 3 == 0
        definition << line.chomp
      elsif index % 3 == 1
        answer << line.chomp
      end
    end
    definition.zip(answer)
  end

end


class Deck
  attr_reader :card_array

  def initialize(file)
    @card_array = []
    @file = file
    load!
    shuffle_deck!
  end

  def shuffle_deck!
    @card_array.shuffle!
  end

  def load!
    DeckData::cards(@file).each do |card_data|
      @card_array << Card.new(card_data)
    end
  end
end

class Card
  attr_reader :definition, :answer

  def initialize(card_data = [])
    @definition = card_data[0]
    @answer = card_data[1]
  end

end

module Ui
  def splash_screen
    puts "Welcome to Flash Cards Game!"
    puts "Type 'show' to reveal solution"
    puts "Type 'exit!' to exit the game"
    puts " " 
  end

  def self.user_output(text)
    puts text
    puts " "
  end

  def self.user_input
    print "Guess: "
    gets.chomp
  end

end

class Game
  include Ui
  
  def initialize(deck)
    @card_array = deck.card_array
    play_deck
  end

  def play_deck
    splash_screen
    @card_array.each do |card|
      break if play_card(card) == "break" 
    end
    Ui::user_output("Thanks for playing!")

  end

  def play_card(card)
    Ui::user_output("Definition: #{card.definition}")
    answer = Ui::user_input
    if evaluate_answer(card, answer)
      Ui::user_output("Correct!")
    elsif answer == "show"
      Ui::user_output("The answer is: #{card.answer}!")
    elsif answer == "exit!"
      return "break"
    else
      Ui::user_output("Erroneous!!")
      play_card(card)
    end
  end

  def evaluate_answer(card, answer)
    card.answer == answer
  end

end

########## Driver code #########

# Setting up new deck with cards.txt file
deck1 = Deck.new('cards.txt')
# Initializing Game!
Game.new(deck1)

