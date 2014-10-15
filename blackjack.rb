require 'deck-of-cards'

@deck = DeckOfCards.new

@deck = @deck.shuffle

def find_values(cards)
  ranks = cards.map{|card|card.to_s.split(' ').first}

  ranks = ranks.map do |card|
    if card == "Jack" || card == "Queen" || card == "King"
      card = "10"
    elsif card == "Ace"
      card = "1"
    else
      card = card
    end
  end
  return ranks.map(&:to_i).inject(:+)
end

def hit_or_stay
  while find_values(@player_cards) <= 21
    puts "Your total is #{find_values(@player_cards)}"
    puts "Would you like to hit(h) or stay(s)?"
    choice = gets.chomp
  
    if choice == 'h'
      @player_cards << @deck.shift
	  puts "Your total is #{find_values(@player_cards)}"
    end
	break if choice == 's'
  end
  
  @dealer_cards << @deck.shift if find_values(@dealer_cards) < 16
  puts "Dealer total is #{find_values(@dealer_cards)}"
	
end

def won_bet?
  if ((find_values(@player_cards) > find_values(@dealer_cards)) && find_values(@player_cards) <= 21) || find_values(@dealer_cards) > 21
    puts "Congratulations! You won $#{@bet}."
	@money += @bet
  else
    puts "Sorry. You've lost $#{@bet}."
	@money -= @bet
  end
end

def round
  @deck = @deck.shuffle
  @player_cards = @deck.shift(2)
  @dealer_cards = @deck.shift(2)
  puts "You currently have $#{@money}"
  puts "How much money do you want to bet?"
  @bet = gets.chomp.to_i
  while @bet > @money
    puts "You don't have that much money! You are going all-in instead"
	@bet = @money
  end
  
end
 
 puts "Welcome to Blackjack!"
 @money = 1000
 
def play
  round
  hit_or_stay
  won_bet?
end

play

def play_again?
  if @money > 0
    puts "Would you like to deal(d) or quit(q)"
	@response = gets.chomp
	if @response == 'd'
	  play
	end
  else
    puts "Game Over!"
  end
end

play_again?