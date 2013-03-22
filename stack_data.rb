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


puts DeckData::cards('cards.txt')
