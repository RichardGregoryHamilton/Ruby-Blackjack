require 'rubygems'
require 'active_support/inflector'

class RankOutOfRangeError < StandardError; end
class SuitOutOfRangeError < StandardError; end

class Suit
  SUITS = [ "Heart", "Diamond", "Club", "Spade" ]

  def initialize(suit)
    @suit = case suit
    when 0, /h/i
      0
    when 1, /d/i
      1
    when 2, /c/i
      2
    when 3, /s/i
      3
    else
      throw SuitOutOfRangeError
    end
  end

  def to_s
    SUITS[@suit]
  end

  def to_c
    SUITS[@suit][0].downcase
  end
end

class Rank
  RANKS = [ "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King", "Ace" ]
  NUMS = [0,1,2,3,4,5,6,7,8,9,10,11,12]
  CHARS = [2,3,4,5,6,7,8,9,10] + [ "J", "Q", "K", "A" ]
  VALUES = [2,3,4,5,6,7,8,9,10] + [ 10, 10, 10, 10 ]

  def initialize(rank)
    throw RankOutOfRangeError unless (0..12) === rank.to_i 
    @rank = rank.to_i
  end

  def to_s
    RANKS[@rank]
  end
  
   def to_c
    CHARS[@rank]
  end

  def to_n
    NUMS[@rank]
  end

  def value 
    VALUES[@rank]
  end
end

class Card
  attr_accessor :rank, :suit
  
  def initialize(rank, suit)
    @rank = Rank.new(rank)
    @suit = Suit.new(suit)
  end

  def to_s
    "#{@rank} of #{@suit.to_s.pluralize}"
  end

  def to_db
    "#{rank.to_n}#{suit.to_c}"
  end

  def >(card)
    @rank.to_n > card.rank.to_n
  end
  
  def <(card)
    @rank.to_n < card.rank.to_n
  end

  def value
    @rank.value
  end
  
end

class Deck

  attr_reader :cards
  
  def initialize
    @cards ||= []
  end

  def add_deck
    @cards ||= []
    (0..3).each do |suit|
      (0..12).each do |rank|
        @cards << Card.new(rank, suit)
      end
    end
  end

  def shuffle
    @cards = @cards.sort_by { rand }
  end
  
  def draw
    @cards.shift
  end
   
  def draw_all
    to_discard = @cards
    @cards = []
    to_discard
  end

  def place(card)
    if(card.respond_to?('rank') && card.respond_to?('suit'))
      @cards ||= []
      @cards << card
    end
  end

  def each
    @cards.each { |card| yield card }
  end
        
  def [](index)
    @cards[index]
  end

  def []=(index, card)
    @cards[index] = card unless card.class != Card
  end

  def <<(cards)
    @cards << cards
  end

  def size
    @cards.count
  end

  def to_db
    cards = []
    @cards.each { |card| cards << card.to_db}
    cards.join(",")
  end
end

class Player
  attr_accessor :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end
end