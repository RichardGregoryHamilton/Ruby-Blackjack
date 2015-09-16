Blackjack
=========

Blackjack is a popular gambling game played in casinos. Also known as 21, the game pits a player against a dealer in a card game.

Players are given two cards and must keep track of the sum of the values of the cards

How To Play
==========
* Open a command line and clone this repository. `git clone git@github.com:RichardGregoryHamilton/Blackjack.git`
* Install the ruby gem, `deck-of-cards`. `gem install deck-of-cards`
* Type in `ruby blackjack.rb`

Card Values
===========
    2 - 2
    3 - 3
    4 - 4
    5 - 5
    6 - 6
    7 - 7
    8 - 8
    9 - 9
    10 - 10
    Jack - 10
    Queen - 10
    King - 10
    Ace - 1 or 11

Gameplay
========
For example say you are dealt two cards, an `8 of Hearts` and a `4 of Clubs`

The sum of these 2 cards is (8 + 4) or 12.

Your objective is to get as close to 21 as possible without exceeding it. You are given two choices. 

    Hit - You can draw another card
    Stay - You don't draw another card and retain this value.

Let's say you draw another card
    
    7 of Spades

The sum of your 3 cards is now `(8 + 4 + 7)` or 19.

Since the total is still under 21, you again have the option to either hit or stay. Choosing `hit` is pretty risky here, since if you draw anything higher than a 2 you will forfeit your bet.

If both the player and the dealer have the same total, it results in a `push`, meaning you will get back the money you bet.

STRATEGY
========

Typically, when the value of the sum of your cards is less than 16, you want to hit.

At 15, it is more likely to draw a card that will bring the sum to 21 or less, than one that will bring the sum over 21.


