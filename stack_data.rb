module DeckData

  def self.cards(file)
    array = File.open(file).readlines
    definition = []
    answer = []

    array.each_with_index do |line, index|
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
    self.load!
    self.shuffle_deck!
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


########## Driver code #########

deck1 = Deck.new('cards.txt')
deck1.card_array.each do |card|
  puts card.answer
end   
